# base-files version 3.7-1

# To pick up the latest recommended .bashrc content,
# look in /etc/defaults/etc/skel/.bashrc

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bashrc) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benificial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bashrc file


# Shell Options
# #############

# See man bash for more options...

# Don't wait for job termination notification
# set -o notify

# Don't use ^D to exit
# set -o ignoreeof

# Use case-insensitive filename globbing
# shopt -s nocaseglob

# Make bash append rather than overwrite the history on disk
# shopt -s histappend

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell


# Completion options
# ##################

# These completion tuning parameters change the default behavior of bash_completion:

# Define to access remotely checked-out files over passwordless ssh for CVS
# COMP_CVS_REMOTE=1

# Define to avoid stripping description in --option=description of './configure --help'
# COMP_CONFIGURE_HINTS=1

# Define to avoid flattening internal contents of tar files
# COMP_TAR_INTERNAL_PATHS=1

# If this shell is interactive, turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
# case $- in
#   *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
# esac

if [ -n "$PS1" ]; then
  if [ -r /etc/bash_completion ]; then
    # Source completion code.
    . /etc/bash_completion
  fi
fi


# History Options
# ###############

# Don't put duplicate lines in the history.
export HISTCONTROL="ignoredups"

# Ignore some controlling instructions
# export HISTIGNORE="[   ]*:&:bg:fg:exit"
export HISTIGNORE="&:ls:[bf]g:exit:gst:gl:gp:gitx"

# Whenever displaying the prompt, write the previous line to disk
# export PROMPT_COMMAND="history -a"

# Aliases
# #######

# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.

# Interactive operation...
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Misc :)
# alias less='less -r'                          # raw control characters
# alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias myips="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\   -f2"

# Some shortcuts for different directory listings
# alias ls='ls -hF --color=tty'                 # classify files in colour
# alias dir='ls --color=auto --format=vertical'
# alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
# alias l='ls -CF'                              #

# Moving up directories
alias ..='cd ..'
alias ...='cd .. && cd ..'
alias ....='cd .. && cd .. && cd ..'
alias .....='cd .. && cd .. && cd .. && cd ..'

# Rails aliases
# alias sc='./script/console'
function sc {
	if [ -f './script/rails' ]; then
		./script/rails console $*
	else
		./script/console $*
	fi
}
# alias sr='./script/runner'
function sr {
	if [ -f './script/rails' ]; then
		./script/rails runner $*
	else
		./script/runner $*
	fi
}
# alias ss='./script/server'
function ss {
	if [ -f './script/rails' ]; then
		./script/rails server $*
	elif [ -f './script/server' ]; then
		./script/server $*
	else
	  ruby -r webrick -e "trap('INT')  { @server.stop }; (@server = WEBrick::HTTPServer.new(:DocumentRoot => Dir.pwd, :Port => 3000)).start"
	fi
}
# alias sg='./script/generate'
function sg {
	if [ -f './script/rails' ]; then
		./script/rails generate $*
	else
		./script/generate $*
	fi
}
alias tfd='tail -f log/development.log'
alias tfp='tail -f log/production.log'
alias atr='autotest -rails'
alias rdm='rake db:migrate'
alias rr='rake routes'

alias b='bundle'

# Aliases for git
alias gl='git pull'
alias gp='git push'
alias gb='git branch -a -v'
alias gst='git status'
alias gss='ruby ~/.submodule_status.rb `pwd`'
alias gd='git diff | gitx'
alias gdi='git diff --ignore-space-change | gitx'
alias gdc='git diff --cached | gitx'
alias gdic='git diff --cached --ignore-space-change | gitx'
alias gi='git commit'
alias gc='git checkout'

function git-add-remote-branch {
  git push origin origin:refs/heads/$1
}

function git-add-remote-branch-and-checkout {
  git push origin origin:refs/heads/$1
  git checkout --track -b $1 origin/$1
}

function git-remove-remote-branch {
  git push origin :heads/$1
}

complete -o bashdefault -o default -o nospace -F _git_pull gl 2>/dev/null \
	|| complete -o default -o nospace -F _git_pull gl
complete -o bashdefault -o default -o nospace -F _git_push gp 2>/dev/null \
	|| complete -o default -o nospace -F _git_push gp
complete -o bashdefault -o default -o nospace -F _git_status gst 2>/dev/null \
	|| complete -o default -o nospace -F _git_status gst
complete -o bashdefault -o default -o nospace -F _git_checkout gc 2>/dev/null \
	|| complete -o default -o nospace -F _git_checkout gc
complete -o bashdefault -o default -o nospace -F _git_commit gi 2>/dev/null \
	|| complete -o default -o nospace -F _git_commit gi


# Aliases for ruby

# use completion and require rubygems by default for irb
alias irb='irb -r irb/completion -rubygems'

alias gemdir='gem env gemdir'

# really awesome function, use: cdgem <gem name>, cd's into your gems directory
# and opens gem that best matches the gem name provided
function cdgem {
  cd `gemdir`/gems
  cd `ls | grep $1 | sort | tail -1`
}
function gemdoc {
  GEMDIR=`gemdir`/doc
  open $GEMDIR/`ls $GEMDIR | grep $1 | sort | tail -1`/rdoc/index.html
}
function mategem {
  GEMDIR=`gemdir`/gems
  mate $GEMDIR/`ls $GEMDIR | grep $1 | sort | tail -1`
}

function _gem_list {
  COMPREPLY=($(compgen -W "$(ls `gemdir`/gems)" -- "${COMP_WORDS[COMP_CWORD]}"))
}
function _gem_doc_list {
  COMPREPLY=($(compgen -W "$(ls `gemdir`/doc)" -- "${COMP_WORDS[COMP_CWORD]}"))
}

complete -F _gem_list cdgem
complete -F _gem_list mategem
complete -F _gem_doc_list gemdoc


function sshc {
  if [ "autodata1" == "$1" ]
  then
    ssh xspond@autodata1.xspond.com
  elif [ "client1" == "$1" ]
  then
    ssh xspond@207.32.178.195
  elif [ "data" == "$1" ]
  then
    ssh Administrator@10.10.10.5
  elif [ "dev" == "$1" ]
  then
    ssh xspond@dev.xspond.com
  elif [ "facebook1" == "$1" ]
  then
    ssh xspond@facebook1.xspond.com
  elif [ "git" == "$1" ]
  then
    ssh xspond@git.xspond.com
  elif [ "keymaster" == "$1" ]
  then
    ssh keymaster@keymaster.xspond.com
  elif [ "legacy1" == "$1" ]
  then
    ssh xspond@legacy1.xspond.com
  elif [ "media1" == "$1" ]
  then
    ssh xspond@media.xspond.com
  elif [ "p1" == "$1" ]
  then
    ssh xspond@production1.xspond.com
  elif [ "php1" == "$1" ]
  then
    ssh xspond@php1.xspond.com
  elif [ "staging_autodata" == "$1" ]
  then
    ssh xspond@10.10.10.21
  elif [ "staging_media" == "$1" ]
  then
    ssh xspond@media.xspond.local
  elif [ "staging_xmp1" == "$1" ]
  then
    ssh xspond@10.10.10.23
  elif [ "xmp1" == "$1" ]
  then
    ssh xspond@xmp1.xspond.com
  fi
}
complete -W 'autodata1 client1 data dev facebook1 git keymaster legacy1 media1 p1 php1 staging_autodata staging_media staging_xmp1 xmp1' $default sshc


# Functions
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

export PS1="\h:\W \u\$(__git_ps1 ' {%s}')\$ "
# export PS1="\h:\W \u\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\1}/')\$ "
# export PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "
# stty erase 

# export EC2_HOME=/home/Admin/ec2-api-tools-1.2-13740
# export PATH=$PATH:$EC2_HOME/bin
# export EC2_PRIVATE_KEY=~/.ec2/pk-Y4HR7ABMOEFP56SQUHSEL5FBYT3A753C.pem
# export EC2_CERT=~/.ec2/cert-Y4HR7ABMOEFP56SQUHSEL5FBYT3A753C.pem
# export JAVA_HOME="/cygdrive/c/Program Files/Java/jdk1.6.0_03"

export PATH=$PATH:/usr/local/git/bin:/Library/PostgreSQL/8.3/bin

export MANPATH=/usr/local/git/man:$MANPATH

export CDPATH=".:~:~/webdev:~/Desktop:~/Desktop/Imports"

export CLICOLOR="1"

export RUBY_HEAP_MIN_SLOTS=250000
export RUBY_HEAP_SLOTS_INCREMENT=25000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000

if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi
[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion
