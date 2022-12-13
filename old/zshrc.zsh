# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/taylor/.oh-my-zsh"


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


# export PATH=/home/taylor/.pyenv/versions/3.8.0/bin/python:$PATH

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
setxkbmap -option caps:escape

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
# disable virtual env prompt prefix
export VIRTUAL_ENV_DISABLE_PROMPT=1

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/home/taylor/.local/bin:$PATH"


#checkip stuff
export VT_KEY="3f467c56a53c5b5458a86e1de76db9df801c9c2362b0e9841594c45e3186f1e9"
export OTX_KEY="82149ec2ab1879de95b3de41da65e3eeede20f751b0de89569182855d924962f"

# systemd stuff
export SYSTEMD_EDITOR=vim


export PATH="/home/taylor/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"


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

    # activating tmux with while ALREADY in a venv
    # can cause issues with pre/post hooks
    if [[ "$VIRTUAL_ENV" != "" ]]
    then
        deactivate
    fi

    PROJECT_DIRECTORY="`realpath $@`"

    # message="Found virtualenv for ${VENV_NAME}"
    # tmux send-keys -t $SESSION_NAME:${@} "echo ${message}" Enter
    function venv_connect {

        VENV_NAME=`basename "echo ${PROJECT_DIRECTORY}"`
        VENV_DIR=${WORKON_HOME}/${VENV_NAME}
        WORK="workon ${VENV_NAME}"

        if [ -d $VENV_DIR ]
        then
            tmux send-keys -t $SESSION_NAME:${@} "$WORK" Enter
        else
            message='Might want to run ./scripts/start.sh'
            tmux send-keys -t $SESSION_NAME:${@} "echo $message" Enter
        fi
    }


    function vim_window {
        tmux rename-window -t $SESSION_NAME:0 'vim'
        tmux send-keys -t $SESSION_NAME:0 'vim "."'
    }


    function dev_window {
        tmux new-window -t $SESSION_NAME
        tmux rename-window -t $SESSION_NAME:1 'development'
        venv_connect 1
    }


    function git_window {
        git_tmux="git status 2&> /dev/null || (git init && git status)"

        tmux new-window -t $SESSION_NAME
        tmux rename-window -t $SESSION_NAME:2 'git'
        tmux send-keys -t $SESSION_NAME:2 $git_tmux Enter
    }



    tmux new-session -d -s $SESSION_NAME

    vim_window
    dev_window
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

# ========================================
#  virtualenvwrapper stuff
# ========================================

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

export DJSTRIPE_WEBHOOK_SECRET='whsec_CEaTBJj51ohjbKtFEVvFWmhrD7EwpRAQ'


export PATH=$PATH:/usr/local/go/bin

export PWDEBUG=1




# see ~/.old_rc for old things
