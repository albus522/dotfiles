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

ulimit -n 10240

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

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

  HOMEBREW_PREFIX=$(brew --prefix)
  if type brew &>/dev/null; then
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
      source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
        [[ -r "$COMPLETION" ]] && source "$COMPLETION"
      done
    fi
  fi
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

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


PROJ_DIR="$HOME/webdev"

function __rbenv_ruby_version() {
	if [[ "$PWD" == "$PROJ_DIR"* ]]; then
		printf "${1:- (%s)}" `rbenv version-name`
	fi
}

function __custom_working_dir() {
	if [[ "$PWD" == "$PROJ_DIR/"* ]]; then
		printf "${1:-%s}" "${PWD#*webdev/}"
	elif [[ "$PWD" == "$HOME" ]]; then
		printf "${1:-%s}" "~"
	else
		dir=`basename "$PWD"`
		printf "${1:-%s}" "$dir"
	fi
}

export PS1="\[\033[G\]\h:\u \[\e[0;33m\]\$(__custom_working_dir)\[\e[0m\]"

if type -t __git_ps1 > /dev/null
then
	export GIT_PS1_SHOWDIRTYSTATE="true"
	export GIT_PS1_SHOWUPSTREAM="true"
	export PS1="$PS1\$(__git_ps1 ' {%s}')"
elif which git > /dev/null
then
	export PS1="$PS1\$(git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ {\1}/')"
fi

export PS1="$PS1\$(__rbenv_ruby_version)"

export PS1="$PS1 \$ "

# stty erase 

# export EC2_HOME=/home/Admin/ec2-api-tools-1.2-13740
# export PATH=$PATH:$EC2_HOME/bin
# export EC2_PRIVATE_KEY=~/.ec2/pk-Y4HR7ABMOEFP56SQUHSEL5FBYT3A753C.pem
# export EC2_CERT=~/.ec2/cert-Y4HR7ABMOEFP56SQUHSEL5FBYT3A753C.pem
# export JAVA_HOME="/cygdrive/c/Program Files/Java/jdk1.6.0_03"

# Setup CDPATH

ORDERED_SUBFOLDERS="clients internal libraries electronics personal"

CDPATH=".:~:$PROJ_DIR"
for FOLDER in $ORDERED_SUBFOLDERS; do
  CDPATH="$CDPATH:$PROJ_DIR/$FOLDER"
done
export CDPATH="$CDPATH"

export CLICOLOR="1"

# export CHOST="x86_64-pc-linux-gnu"
# export CFLAGS="-march=nocona -O3 -pipe -fomit-frame-pointer"
# export CXXFLAGS="${CFLAGS}"

# export RUBY_HEAP_MIN_SLOTS=1000000
# export RUBY_HEAP_SLOTS_INCREMENT=1000000
# export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
# export RUBY_GC_MALLOC_LIMIT=1000000000
# export RUBY_HEAP_FREE_MIN=500000

export BUNDLER_EDITOR=code

export EVENT_NOKQUEUE=yes

# export C_INCLUDE_PATH=/opt/X11/include

# export PATH=/usr/local/share/npm/bin:$PATH

export PATH="/usr/local/sbin:$PATH"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="./.bin:$PATH"

export DIFF_TOOL=code

# export SSL_CERT_FILE=/usr/local/opt/curl-ca-bundle/share/ca-bundle.crt


if [ -e "${HOME}/.aliases" ] ; then
  source "${HOME}/.aliases"
fi

# added by travis gem
if [ -e "/Users/dgenord/.travis/travis.sh" ] ; then
	source /Users/dgenord/.travis/travis.sh
fi

# export LDFLAGS=-L/usr/local/opt/libxml2/lib
# export CPPFLAGS=-I/usr/local/opt/libxml2/include

export PATH="~/.dotfiles/bin:$PATH"

export DISABLE_SPRING=true
export DISABLE_PRY_RAILS=1
export DISABLE_SIMPLE_COV=true

export HOMEBREW_NO_ANALYTICS=1

export NVM_DIR="/Users/dgenord/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export PARALLEL_TEST_PROCESSORS=4
