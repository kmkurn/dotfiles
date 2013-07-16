# Some useful aliases.
# Copied from /usr/share/doc/bash/examples/startup-files/Bash_aliases
# from bash-doc package with some modifications.

alias clean='rm -f \#* *~ .*~ *.bak .*.bak *.tmp .*.tmp *.swp .*.swp core a.out'
alias ll='ls -lF'
alias lh='ls -lhF'

# Function as an alias to 'ps aux | grep <pattern>'
psgrep() {
	ps aux | grep "$1"
}
