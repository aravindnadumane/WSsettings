#!/bin/sh

# Open the file in the Notepad++
npp() {
    filelineNo=$(sed 's/:/ -n/' <<<$1)
	#echo "processed: $filelineNo"
    /c/Progra~2/Notepad++/notepad++.exe $filelineNo &
}

#get the link to the file to be shared
toShare(){
    file2cpy=$(sed 's/\//_/g' <<< $1)
    shareDrive="//path/to/share/drive/"
    destPath="$shareDrive$2"
    mkdir $destPath;cp $1 $destPath;
    echo -e "\n\\e[38;5;198mCopied to path:\e[0m";
    echo -e "\e[0;49;92mUnix:\e[0m\e[1;49;35m $destPath\\$file2cpy \e[0m";
    echo -e "\e[0;49;93m Win:\e[0m\e[1;49;34m $destPath\\$file2cpy \e[0m"| sed 's/\//\\/g';
}

## Perl NYT profiling

NYTPerlProfile() {
perl -d:NYTProf $1 $2
perl /c/Strawberry32/perl/site/bin/nytprofhtml --open
start ./nytprof/index.html
}
alias NYTPerlHtml='perl /c/Strawberry32/perl/site/bin/nytprofhtml --open'
alias NYTPerlOpenReport='start ./nytprof/index.html'
## Sourcing
source /c/bins/hi

## EXPORT ##
PATH=$PATH:/c/Progra~1/Beyond\ Compare\ 4/
export PATH