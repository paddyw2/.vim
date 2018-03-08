set +x
alias python=python3
alias python2=python
alias hadoop="ssh patrick.withams@136.159.79.112"
alias fullscreen="gnome-terminal --full-screen"
#. /etc/bashrc

export PATH=$PATH:/home/ugc/patrick.withams/.local/bin/:~/.homebrew-scripts/
export CLASSPATH=$CLASSPATH:/home/ugc/patrick.withams/.java-source/


export VISUAL=vim
export EDITOR="$VISUAL"

## for prompt

function get_branch() {
    branch=`git status 2>&1 | tee | grep "On branch" | cut -d ' ' -f3`
    size=${#branch}
    if [ $size -gt 0 ]; then
        printf " [$branch]"
    fi

}

function get_pwd() {
    preswd=`pwd |rev | cut -d '/' -f1 | rev`
    if [ "$preswd" == "$USER" ]; then
        printf "~"
    else
        printf "$preswd"
    fi
}

export PS1="\[$(tput bold)\]\[\033[01;38;5;48m\]➜\[\e[m\] \[$(tput bold)\]\[\033[01;38;5;75m\]\`get_pwd\`\[\033[01;38;5;212m\]\`get_branch\`\[\e[m\] "
