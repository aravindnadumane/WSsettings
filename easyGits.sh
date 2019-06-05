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
