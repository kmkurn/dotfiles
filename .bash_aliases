# Some useful aliases.
# Copied from /usr/share/doc/bash/examples/startup-files/Bash_aliases
# from bash-doc package with some modifications.

# Some simple aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -lF'
alias lh='ls -lhF'

# Alias to clean unused files
alias clean='rm -f \#* *~ .*~ *.bak .*.bak *.tmp .*.tmp *.swp .*.swp core a.out'

# Alert after some processes finish
# Usage: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# List all processes matching a PATTERN
# Usage: psgrep PATTERN
psgrep() {
	ps aux | grep "$1"
}

# Batch kill processes matching a PATTERN
# Usage: pskill PATTERN
pskill() {
	ps ax | grep "$1" | grep -v grep | awk '{ print $1 }' | xargs kill
}

# List NUMBER processes sorted by CPU usage
# Usage: pssort NUMBER
pssort() {
	DEFAULT_NUM=3
	if [ "$#" -ge 1 ]; then
		num="$1"
	else
		num=$DEFAULT_NUM
	fi
	ps aux | tail -n+2 | sort -nr -k 3 | head -n "$num"
}
