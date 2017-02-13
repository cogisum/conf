# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

export LC_ALL="en_US.UTF-8"
export EDITOR=vim
if command -v trash >/dev/null; then
    alias rm=trash
fi
