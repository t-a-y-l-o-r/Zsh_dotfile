# ========================================
#    NOTE
# ========================================

# see ~/.old_rc for old things

# ========================================
#    END NOTE
# ========================================

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="/home/taylor/.oh-my-zsh"
export ZSH="$HOME/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="sporty_256" maybe
# ZSH_THEME="hyperzsh"
ZSH_THEME="fino"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


########## This must come before the plugins
export VIRTUALENVWRAPPER_PYTHON=$(which python3)

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# ====================
#  OLD ZSH DOT FILE
# ====================

# Enable colors and change prompt:
autoload -U colors && colors

# PS1="%B%{$fg[green]%}༇ %{$reset_color%}%b "

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)        # Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# check current ip
alias my_ip="curl icanhazip.com"
# better than restarting
alias rezsh="source ~/.zshrc"

# ensure caps lock is escape
# LINUX ONLY
setxkbmap -option caps:escape

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"


# ========================================
#   RUST
# ========================================

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/home/taylor/.local/bin:$PATH"


# systemd stuff
export SYSTEMD_EDITOR=vim

# ========================================
#   HELPERS
# ========================================

function rabbit {
    sudo docker run -d -p 5672:5672 rabbitmq
}

function listen {
    stripe listen --forward-to=localhost:8000/stripe/webhook/
}


function commit_safe {
    git add -A && git commit -m "$@"
}

function commit_unsafe {
    git add -A && git commit -m "$@" --no-verify
}

function dock_manage {
    sudo docker-compose exec web python manage.py "$@"
}

function ios {
  cd ios \
    && pod install \
    && cd .. \
    && git checkout develop ios/atriahealth.xcodeproj/project.pbxproj
}


# open sessions in tmux
function session {

    if [ $# -eq 0 ] || [ ! -d "$1" ]
    then
        echo '`session` requires a directory argument' >&2;
        return 1
    fi


    SESSION_NAME="work"
    tmux has-session -t $SESSION_NAME &> /dev/null

    if [ $? -eq 0 ]
    then
        echo "session $SESSION_NAME already exists! Either kill it or attach to it" >&2
        return 1
    fi

    # activating tmux while ALREADY in a venv
    # can cause issues with pre/post hooks
    if [[ "$VIRTUAL_ENV" != "" ]]
    then
        deactivate
    fi

    PROJECT_DIRECTORY="`realpath $@`"
    if ! [[ -d $PROJECT_DIRECTORY ]];
    then
        echo "Provided argument is not a dir: ${PROJECT_DIRECTORY}" >&2
        return 1
    fi



    function vim_window {
        tmux rename-window -t $SESSION_NAME:0 'vim'
        tmux send-keys -t $SESSION_NAME:0 "cd ${PROJECT_DIRECTORY}" Enter
        tmux send-keys -t $SESSION_NAME:0 'vim "."'
    }


    function dev1_window {
        tmux new-window -t $SESSION_NAME
        tmux send-keys -t $SESSION_NAME:1 "cd ${PROJECT_DIRECTORY}" Enter
        tmux rename-window -t $SESSION_NAME:1 'dev1'
    }

    function dev2_window {
        tmux new-window -t $SESSION_NAME
        tmux send-keys -t $SESSION_NAME:2 "cd ${PROJECT_DIRECTORY}" Enter
        tmux rename-window -t $SESSION_NAME:2 'dev2'
    }


    function git_window {
        git_tmux="git status 2&> /dev/null || (git init && git status)"

        tmux new-window -t $SESSION_NAME
        tmux rename-window -t $SESSION_NAME:3 'git'
        tmux send-keys -t $SESSION_NAME:3 "cd ${PROJECT_DIRECTORY}" Enter
        tmux send-keys -t $SESSION_NAME:3 $git_tmux Enter
    }


    tmux new-session -d -s $SESSION_NAME

    vim_window
    dev1_window
    dev2_window
    git_window

    tmux attach -t $SESSION_NAME
}


function _progress {

  function run_or_exit {
    error=`$*` 2>&1
    $error || (endspin "Error: $error" && exit 1)
  }

  sp="▁▂▃▄▅▆▇█▇▆▅▄▃▂▁"
  sc=0

  function spin {
    printf "\r%s%s" "$(tput el) [$*] " "${sp[sc++]}"
    ((sc==${#sp})) && sc=0
  }

  function endspin {
    printf "\r%s\n" "$(tput el)[$*]"
  }

  # run input program
  COMMAND=${@:2}

  run_or_exit "${=COMMAND}" &!
  PID=$!
  echo -n ' '
  while [ -d /proc/$PID ]
  do
    spin "$*"
    sleep 1
  done
  endspin "$1 Done!"
}

function progress {
  FILE="$1"
  while read -r COMMAND
  do
    _progress "${=COMMAND}"
  done < $FILE
}

# Load zsh-syntax-highlighting; should be last.
source /home/taylor/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
fpath+=${ZDOTDIR:-~}/.zsh_functions

function edit {
  emacs --no-window-system
}

function devices {
  xcrun simctl list devices
}

function compare_ios {
  yarn run react-native run-ios --simulator "iPhone 11" && \
  yarn run react-native run-ios --simulator "iPhone 12" && \
  yarn run react-native run-ios --simulator "iPhone 13";
}

function clean_proj {
  git stash push ios/Podfile.lock ios/atriahealth.xcodeproj/project.pbxproj yarn.lock;
}

function check_print {
  git status | grep 'modified' | awk -F ':' '{print $2}' | xargs grep -E 'console|print'
}

function git_delete_pattern {
  git branch --list "$@" | xargs -r git branch -D
}

function pbpaste() {
  xclip -selection clipboard -o > $1
}
function pbcopy() {
  xclip -selection clipboard < $1
}

# function add_command() {
#   perl ~/Git/scripts/django_command.pl $1 $2
# }

export PATH="$PATH:~/Git/scripts"
function __() {
  function nested_script() {
    local subfolder=$1
    local script=$2
    local full_path

    if [[ ! -d ~/Git/scripts/$subfolder ]]; then
      return 1
    fi

    full_path=$(find ~/Git/scripts/$subfolder -type f -name "$script.*" 2>/dev/null)
    if [[ -z $full_path ]]; then
      return 1
    fi
    echo "$full_path"
    return 0
  }
  function top_level_script() {
    local script=$1
    full_path=$(find ~/Git/scripts/ -type f -name "$script.*" 2>/dev/null)

    if [[ -z $full_path ]]; then
      return 1
    fi
    echo "$full_path"
    return 0
  }
  function run_script() {
    script=$1
    shift 1
    case $script in
      *.sh)
        bash $script "$@"
        ;;
      *.py)
        python $script "$@"
        ;;
      *.pl)
        perl $script "$@"
        ;;
      *)
        filetype=$(echo "${script##*.}")
        echo "Cannot find a runner for script of type: $filetype"
        return 1
        ;;
    esac
  }

  script_path=$(top_level_script "$@")
  if [ $? -eq 0 ]; then
    shift 1
    run_script $script_path "$@"
    return 0
  fi

  script_path=$(nested_script "$@")
  if [ $? -eq 0 ]; then
    shift 2
    run_script $script_path "$@"
    return 0
  fi
  echo "Unable to determine command"
  return 1
}

function maven() {
  $HOME/perl5/perlbrew/perls/perl-5.36.1/bin/perl5.36.1 "$HOME/Git/maven/bin/maven.pl" "$@"
}

function bootstrap {
  files=(
    ~/.config/maven/rc
  )
  for file in "${files[@]}";
  do
    if [[ -f $file ]];
    then
      source "$file"
    fi
  done
}

RESEARCH_EXCLUSION="$HOME/.google_exclusion";
function free-me {
  echo "$1" >> $RESEARCH_EXCLUSION;
}

function query-google {
  output="\"$1\""
  while read -r line;
  do
    output="${output} -\"${line}\""
  done < $RESEARCH_EXCLUSION
  echo $output
}


# ========================================
#  virtualenvwrapper stuff
# ========================================

# NEW PROJECTS USE DIRENV
# export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Work

# disable virtual env prompt prefix
export VIRTUAL_ENV_DISABLE_PROMPT=1

# linux
source /usr/local/bin/virtualenvwrapper.sh
# macos

# source /opt/homebrew/bin/virtualenvwrapper.sh
export PATH=$PATH:/usr/local/go/bin

# ========================================
#   pyenv
# ========================================

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PYENV_ROOT/shims:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi


# ========================================
#   VIM
# ========================================

# still need to install nvim
alias vim="nvim"


# ========================================
#   a health client setup
# ========================================

eval "$(direnv hook zsh)"

# export PATH="$HOME/.poetry/bin:$PATH"
#
# alias pg_start="launchctl load ~/Library/LaunchAgents"
# alias pg_stop="launchctl unload ~/Library/LaunchAgents"
# export PGDATA="/usr/local/var/postgres/"

# ========================================
#   Fly.io
# ========================================

export FLYCTL_INSTALL="/home/taylor/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# ========================================
#   Go
# ========================================

[[ -s "/home/taylor/.gvm/scripts/gvm" ]] && source "/home/taylor/.gvm/scripts/gvm"
export PATH=$PATH:$HOME/.gvm/bin


# ========================================
#   Perl is a greasy hamburger and I want more
# ========================================

source ~/perl5/perlbrew/etc/bashrc
PATH="/home/taylor/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/taylor/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/taylor/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/taylor/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/taylor/perl5"; export PERL_MM_OPT;

# maven
source /home/taylor/Git/maven/utility_belt/autocomplete.zsh
bootstrap

# ========================================
#   Heroku
# ========================================
# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/taylorcochran/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# ========================================
#   Node sucks
# ========================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# ========================================
#   Kubernetes but it's a custom tool now and this helps autocompletion
# ========================================

fpath=($ZSH/custom/completions $fpath)

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# ========================================
#   OLD SHIT
# ========================================
# export PATH="/home/taylor/.pyenv/bin:$PATH"
# export PATH="/usr/local/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# export PWDEBUG=1

# ========================================
#   Shit auto-added without my knowledge
# ========================================
export PATH="$PATH:/opt/mssql-tools18/bin"

