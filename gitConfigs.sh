[user]
	name = Aravind Nadumane
	email = 
[core]
	symlinks = true
	longpaths = true
	editor = 'C:/Program Files (x86)/Notepad++/notepad++.exe' -multiInst -notabbar -nosession -noPlugin
[diff]
	tool = beyondc
[merge "bc"]
    path = c:/program files/beyond compare 4/bcomp.exe
	tool = bc
[http]
	proxy = 


[color "branch"]
current = green reverse
local = yellow
remote = red
    
[difftool]
[difftool "beyondc"]
#    cmd = \"c:/program files/beyond compare 4/BCompare.exe\" "$(cygpath -w $LOCAL)" "$(cygpath -w $REMOTE)"
#    cmd = \"c:/Program Files/Beyond Compare 4/BCompare\"
    cmd = \"c:/Program Files/Beyond Compare 4/bcomp.exe\" \"$LOCAL\" \"$REMOTE\"
	
[difftool "bc3"]
    prompt = false
    path = c:/program files/beyond compare 4/bcomp.exe

[alias]
    co = checkout
    st = status
#    lola = log --graph --decorate --pretty=oneline --pretty=format:'%h %Cblue%d%Creset %s' --abbrev-commit --all
#    lol = log --graph --decorate --pretty=oneline --pretty=format:'%h %Cblue%d%Creset %s' --abbrev-commit
    lola = log --graph --decorate --pretty=oneline --abbrev-commit --all
    lol = log --graph --decorate --pretty=oneline --abbrev-commit 
    linear = log --oneline --decorate 
    hisa = log --all --graph\n--pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\n--abbrev-commit --date=relative
    his = log --graph\n--pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\n--abbrev-commit --date=relative --decorate 
	dirdiff  = difftool --dir-diff --no-symlink
    lg1 = log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
    lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all

[color]
    ui = auto
	
[color "grep"]
    linenumber = yellow bold
    match = red
    filename = magenta 
[merge]
	tool = beyondc
[mergetool]
  prompt = false    
[mergetool "beyondc"]
	trustExitCode = true
    cmd = \"c:/Program Files/Beyond Compare 4/bcomp.exe\" \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\"
[credential]
	helper = wincred
