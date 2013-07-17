# Some useful aliases.
# Copied from /usr/share/doc/bash/examples/startup-files/Bash_aliases
# from bash-doc package with some modifications.

# Alias to clean unused files
alias clean='rm -f \#* *~ .*~ *.bak .*.bak *.tmp .*.tmp *.swp .*.swp core a.out'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -lF'
alias lh='ls -lhF'

# Add an "alert" alias. Usage: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Function as an alias to 'ps aux | grep <pattern>'
psgrep() {
	ps aux | grep "$1"
}

# Function to batch kill processes matching a given <pattern>
pskill() {
	ps ax | grep "$1" | grep -v grep | awk '{ print $1 }' | xargs kill
}
