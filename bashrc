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


# Functions
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }


function sshc {
  if [ "api1" == "$1" ]
  then
    ssh xspond@api1 -o 'ProxyCommand ssh gateway@proxy1.xspond.com exec nc %h %p'
  elif [ "autodata1" == "$1" ]
  then
    ssh xspond@autodata1.xspond.com
  elif [ "aws1" == "$1" ]
  then
    ssh ubuntu@ec2-184-72-213-130.compute-1.amazonaws.com
  elif [ "client1" == "$1" ]
  then
    ssh xspond@client1.xspond.com
  elif [ "data" == "$1" ]
  then
    ssh Administrator@10.10.10.5
  elif [ "db1" == "$1" ]
  then
    ssh xspond@db1 -o 'ProxyCommand ssh gateway@proxy1.xspond.com exec nc %h %p'
  elif [ "db2" == "$1" ]
  then
    ssh xspond@db2 -o 'ProxyCommand ssh gateway@proxy1.xspond.com exec nc %h %p'
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
  elif [ "old_autodata" == "$1" ]
  then
    ssh xspond@autodata1 -o 'ProxyCommand ssh gateway@proxy1.xspond.com exec nc %h %p'
  elif [ "p1" == "$1" ]
  then
    ssh xspond@production1.xspond.com
  elif [ "php1" == "$1" ]
  then
    ssh xspond@php1.xspond.com
  elif [ "proxy1" == "$1" ]
  then
    ssh xspond@proxy1.xspond.com
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
complete -W 'api1 autodata1 aws1 client1 data db1 db2 dev facebook1 git keymaster legacy1 media1 old_autodata p1 php1 proxy1 staging_autodata staging_media staging_xmp1 xmp1' $default sshc

function tunnel {
  if [ "api1_ipmi" == "$1" ]
  then
    ssh -L 8080:10.10.11.52:80 -N xspond@proxy1.xspond.com
  elif [ "db1_areca" == "$1" ]
  then
    ssh -L 8080:10.10.11.101:80 -N xspond@proxy1.xspond.com
  elif [ "db1_ipmi" == "$1" ]
  then
    ssh -L 8080:10.10.11.51:80 -N xspond@proxy1.xspond.com
  elif [ "db1_mongo" == "$1" ]
  then
    ssh -L 8888:db1:27017 -N xspond@proxy1.xspond.com
  elif [ "db1_mysql" == "$1" ]
  then
    ssh -L 3308:db1:3306 -N xspond@proxy1.xspond.com
  elif [ "db2_mongo" == "$1" ]
  then
    ssh -L 8888:db2:27017 -N xspond@proxy1.xspond.com
  elif [ "dtp_rdc" == "$1" ]
  then
    ssh -L 3389:dtp:3389 -N -C xspond@proxy1.xspond.com
  elif [ "netgear_http" == "$1" ]
  then
    open "http://localhost:9090/"
    ssh -L 9090:10.10.11.5:80 -N -C xspond@proxy1.xspond.com
  elif [ "staging_postgres" == "$1" ]
  then
    ssh -L 5434:127.0.0.1:5432 -N xspond@10.10.10.23
  elif [ "vm1_areca" == "$1" ]
  then
    ssh -L 8080:10.10.11.102:80 -N xspond@proxy1.xspond.com
  elif [ "xmp_postgres" == "$1" ]
  then
    ssh -L 5433:127.0.0.1:5432 -N xspond@xmp1.xspond.com
  fi
}
complete -W 'api1_ipmi db1_areca db1_ipmi db1_mongo db1_mysql db2_mongo dtp_rdc netgear_http staging_postgres vm1_areca xmp_postgres' $default tunnel


# Functions
# #########

# Some example functions
# function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

if type -t __git_ps1 > /dev/null
then
  export PS1="\h:\W \u\$(__git_ps1 ' {%s}')\$ "
elif which git > /dev/null
then
  export PS1="\h:\W \u\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\1}/')\$ "
fi

# stty erase 

# export EC2_HOME=/home/Admin/ec2-api-tools-1.2-13740
# export PATH=$PATH:$EC2_HOME/bin
# export EC2_PRIVATE_KEY=~/.ec2/pk-Y4HR7ABMOEFP56SQUHSEL5FBYT3A753C.pem
# export EC2_CERT=~/.ec2/cert-Y4HR7ABMOEFP56SQUHSEL5FBYT3A753C.pem
# export JAVA_HOME="/cygdrive/c/Program Files/Java/jdk1.6.0_03"

export PATH=$PATH:/usr/local/git/bin:/Library/PostgreSQL/8.3/bin

export MANPATH=/usr/local/git/man:$MANPATH

# Setup CDPATH
PROJ_DIR="~/webdev"
ORDERED_SUBFOLDERS="client_sites citadel omega platform apps xspond blueprints helpers libraries server misc plugins"

CDPATH=".:~:$PROJ_DIR"
for FOLDER in $ORDERED_SUBFOLDERS; do
  CDPATH="$CDPATH:$PROJ_DIR/$FOLDER"
done
export CDPATH="$CDPATH:~/Desktop:~/Desktop/Imports"

export CLICOLOR="1"

export RUBY_HEAP_MIN_SLOTS=250000
export RUBY_HEAP_SLOTS_INCREMENT=25000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000

export BUNDLER_EDITOR=mate

export EVENT_NOKQUEUE=yes

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="./.bin:$PATH"

#if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi
#[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion

if [ -e "${HOME}/.aliases" ] ; then
  source "${HOME}/.aliases"
fi
