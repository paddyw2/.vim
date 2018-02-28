eval "$(rbenv init -)"
# powerline settings
#USE_PATCHED_FONT=true
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
# end powerline

# rust
source $HOME/.cargo/env

# used homebrew vim
alias vim="/usr/local/Cellar/vim/8.0.0559/bin/vim"

# emacs terminal colors
#env TERM=xterm-256color emacs -nw
alias emacs="emacs-25.1"
# homer
PATH=$PATH:/Users/paddy/Downloads//bin/
PATH=$PATH:/Users/paddy/Library/Android/sdk
alias cpsc="ssh patrick.withams@linux.cpsc.ucalgary.ca"
# set vim as default editor (mainly for git)
export VISUAL=vim
export EDITOR="$VISUAL"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# java packages
export CLASSPATH=$CLASSPATH:/Users/Paddy/.java-packages
export CLASSPATH=$CLASSPATH:/Users/Paddy/.java-checker

# go path

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# scala
export PATH=$PATH:/Users/Paddy/Documents/code-libs/scala-2.11.7/bin

# play framework
export PATH=$PATH:/Users/Paddy/.activator/activator-1.3.10-minimal/bin
# misc
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
export PATH=$PATH:/usr/local/sbin
#export TERM=screen-256color

C_INCLUDE_PATH=~/.include_c
export C_INCLUDE_PATH


#old python alias, shows pip3 usage
alias python="python3"
#alias pip="pip3.5"
# to revert to default osx vim, simply brew uninstall vim

# VS code settings
# alias code="open -a 'Visual Studio Code'"
# export LSCOLORS="GxGxBxDxCxEgEdxbxgxcxd"
# source dnvm.sh

# cmus error silence alias
# generates warning about future compatability
alias cmus="cmus 2> /dev/null"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/Paddy/.sdkman"
[[ -s "/Users/Paddy/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/Paddy/.sdkman/bin/sdkman-init.sh"
eval $(/usr/libexec/path_helper -s)

## for prompt
# prompt

export PATH=$PATH:~/.nexustools
export PATH="/usr/local/opt/qt/bin:$PATH"

function get_branch() {
    branch=`git status 2>&1 | tee | grep "On branch" | cut -d ' ' -f3`
    size=${#branch}
    if [ $size -gt 0 ]; then
        printf " [$branch]"
    fi

}

function get_pwd() {
    preswd=`pwd |rev | cut -d '/' -f1 | rev`
    if [ $preswd == "paddy" ]; then
        printf "~"
    else
        printf $preswd
    fi
}

export PS1="\[$(tput bold)\]\[\e[32m\]➜\[\e[m\]  \[$(tput bold)\]\[\e[36m\]\`get_pwd\`\[\033[01;38;5;225m\]\`get_branch\`\[\e[m\] "
