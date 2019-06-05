#!/bin/sh

# Upload the changes to the Gerrit
# upload <branch name>
upload()
{
    #rectify the Tab spaces
    echo -e "\e[38;5;110m Checking for Tabs & Trailing spaces \e[0m"
    [[ -z $TRACE ]] || set -x
    trap "rm -f $tmpf" 0
    tmpf1=$TMP/$$.1.diff
    tmpf2=$TMP/$$.2.diff
    cd $(git rev-parse --show-toplevel)
    git diff HEAD^ --binary -- '*.c' '*.h' '*.cpp' '*.hpp' '*.json' >$tmpf1
    
    perl -p -e 'if(m/^\+/){s/\t/    /g;s/\s+$(\n)/$1/g;}' <$tmpf1 >$tmpf2;
    dos2unix -q $tmpf2
    if ! cmp -s $tmpf1 $tmpf2
    then
        echo -e "\e[38;5;215m   Tabs/White spaces detected,\e[0m\e[93m Applying ..\e[0m"
        sha1Before=$(git rev-parse --short HEAD)
        echo -e "\e[38;5;95m    current commit $sha1Before (backup) \e[0m"
        git apply --binary -R --whitespace=nowarn $tmpf1
        git apply --binary $tmpf2
        echo -e "\e[38;5;243m"
        git commit -a --amend --no-edit
        echo -e "\e[38;5;154m \t-- commit amended -- \e[0m"
    else
        echo -e "\e[38;5;154m \t-- No changes required -- \e[0m"
    fi

    #some checks
    tdbCheck=$(git diff HEAD^ HEAD --name-only | grep --color=always "someUnwantedFiletoBeSkippedForUpload.txt")
    if [ "$tdbCheck" ]
    then 
        echo -e "\e[38;5;209m please revert \e[38;5;15m $tdbCheck \e[38;5;209m to origin/$1 branch!\n\n\e[38;5;196m Aborting Upload."
    else
    #Upload the Changes
        echo -e "\e[38;5;110m\n Uploading the Changes to \e[38;5;197m$1 \e[38;5;110mbranch \e[0m"
        echo -e "\e[38;5;243m"
        git push origin HEAD:refs/for/$1
        echo -e "\e[0m"
    fi
}


#get the statistics of the sub git in the Directory Tree
stat_All_Sub (){
find $1 -name .git -type d -execdir tput setaf 11 \; -execdir pwd \; -execdir git status \;
}

#get the statistics of the sub git in the Directory Tree
stat_All_SubBra(){
#find $1 -name .git -type d -execdir tput setaf 11 \; -execdir pwd \; -execdir git --color=always his  -1 \; -execdir git  --color=always status \;
find $1 -name .git -type d -execdir tput setaf 11 \; -execdir pwd \; -execdir git his  -1 \;
}

#go to the project directory
proj(){
grep $1 /x/.repo/manifests/master.xml | sed 's/.*path\=\"/\/x\//'| sed 's/".*//'
}

stat_All(){
stat_All_Sub | hi '' 'working tree clean' '' 'Not currently on any branch.' '' "noth.*\,"
}

# get the gerrit info on the console
gerritInfo(){
 ssh -p 29418 uidh4821@buic-scm-rbg.contiwan.com gerrit query $1
}

#Seach though  the specified Deirectory for the Branch name given, if it already exist
findBra()
{
    echo -e "\e[38;5;110m looking for gits with\e[38;5;154m $1 \e[38;5;110mBranch Name \e[0m"
    fine=$(find /x/Tresos/ /x/Misc/ -name *.git)
    for gitle in $fine
    do
        if [ "$gitle" != "" ]; then
            # Do something here
            gitle=$(echo $gitle | sed -e 's/\.git.*//g'| sed -e 's/\n//')
            cd $gitle
            gitleBranch=$(git branch -v | grep $1)
            if [ "$gitleBranch" != "" ]; then
                #found the branch here
                shaSha=$(echo $gitleBranch| sed -r 's/^\**[ ]*$1[ ]*//' | perl -pe 's/([a-f0-9]+).*/$1/')
                echo -e "\n\e[38;5;154m path:\e[0m \e[38;5;187m$gitle\e[0m commitID $shaSha"
                gitLog=$(git log --oneline -1 | grep --color=always $shaSha)
                if [ "$gitLog" != "" ]; then
                    echo -e "\e[38;5;154m      ==> log: \e[0m$gitLog \e[0m"
                else
                    echo -e "\e[38;5;215m     ==> Not yet checked out! \e[0m"
                fi
            fi
        fi
    done
}