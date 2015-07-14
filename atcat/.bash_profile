#=====================================================================
# Disable logging terminal commands you've entered and what you've
# searched for when using `less`.
#=====================================================================

# # disable ~/.bash_history
# unset HISTFILE
# export HISTFILE

# # disable ~/.lesshst
# export LESSHISTFILE=-

#=====================================================================
# Editor
#=====================================================================
if [ -z "$EDITOR" ]; then
  if [[ ! -z "`which mvim`" ]]; then
    export EDITOR="mvim -f"
  fi
fi

#=====================================================================
# Terminal - Pretty prompt
#=====================================================================
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

#
# A terminal prompt like:
#
#  username@compname:path$ 
#
#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

#
# A terminal prompt like:
#
#  username:path$ 
#
export PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "

#=====================================================================
# Terminal - Show `pwd` in title bar
#=====================================================================
export PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'

#=====================================================================
# PATH
#=====================================================================

# add ~/bin to PATH.
export PATH="$HOME/bin:$PATH"

# add homebrew-installed binaries to PATH.
export PATH="$PATH:/usr/local/sbin:/usr/local/bin"

