# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=vim
# Path to your oh-my-zsh installation.
export ZSH="/Users/dfs/.oh-my-zsh"

ZSH_THEME="spaceship"

# SPACESHIP_PROMPT_ORDER=(user host dir git node exec_time line_sep jobs exit_code char)

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
# DISABLE_MAGIC_FUNCTIONS=true

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

# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

######################
# User configuration #
######################

# zsh vim mode
# source "/Users/dfs/.oh-my-zsh/custom/plugins/zsh-vim-mode/zsh-vim-mode.plugin.zsh"

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

# Syntax highlighting of shell commands
source /Users/dfs/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# First load fzf stuff as usual.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# [DOES NOT WORK WITH ZSH] Then configure and load this plugin.
# FZF_CTRL_R_EDIT_KEY=ctrl-w
# FZF_CTRL_R_EXEC_KEY=enter
# source ~/.fzf-plugins/history-exec.zsh

# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
# fi

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### UNCOMMENT BELOW FOR CONDA ###

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
#  __conda_setup="$('/Users/dfs/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#  if [ $? -eq 0 ]; then
#      eval "$__conda_setup"
#  else
#      if [ -f "/Users/dfs/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#          . "/Users/dfs/opt/anaconda3/etc/profile.d/conda.sh"
#      else
#          export PATH="/Users/dfs/opt/anaconda3/bin:$PATH"
#      fi
#  fi
#  unset __conda_setup
#  # <<< conda initialize <<<
 
# conda activate abnormal

# export PYSPARK_PYTHON="$(conda activate abnormal; which python3)" # python
export PYSPARK_PYTHON=python

# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi

# arcanist/phabricator
# export PATH="/Users/dfs/installs/arcanist/bin:$PATH"

export SOURCE=/Users/dfs/source
. $SOURCE/tools/dev/common_bash_includes

# venv
export VENV="$SOURCE/.venv"
venv-activate

SPARK_HOME='/Users/dfs/installs/spark-3.1.2-bin-hadoop2.7' # '/Users/dfs/installs/spark-2.3.0-bin-hadoop2.7'
export PATH=$SPARK_HOME/bin:$PATH
export JAVA_HOME="$(readlink "$(jenv prefix)")"

# bidet
# export PYTHONPATH=$PYTHONPATH:$HOME/.bidet/python_content_root

# dbt setup
export DBT_HOME=~/dbt
export DATABRICKS_CLUSTER_ID=0810-212339-wagon371 # eng-dev-cluster

# My ALIASES
# alias python=python3

alias b=black
alias c=clear
alias g=git
alias p=python
alias pi=python -i
alias r='run_pytests --skip-airflow-db'

alias cs='cd ~/source'
alias gr='g log --pretty=format:"%h%x09%an%x09%ad%x09%s"'
alias ciao=exit
alias \ \ ='emacs'

alias gs='g status'
alias ga='g add'
alias gbr='g branch --sort=-committerdate'
alias gl='g pull'
alias gf='g fetch'
# alias goto='g checkout'
# alias goton='goto -b'
# alias gcm='goto main'
alias gml='gcm && gl'
alias glom='gl origin main'
alias gcm='g checkout main'
alias gau='ga -u'
# alias gtt='goto -b'
alias gxb='g branch -D'
alias grm='g rebase main'
alias gco='g commit -m '
alias gm='g branch -m '

alias unstage='git restore --staged'
alias s='ssh'
alias sd='s deploy'
alias sp='s prometheus'

alias gsh='g show HEAD'
alias gtemp="ga -A && gco 'TEMP'"

# gh aliases
alias ad='gh pr create -w'
# alias ad='gh pr create --fill --reviewer john-rak,cdgasperi,justinyoung127,hrl20,micahjz'
alias arcland='gh pr merge --delete-branch --squash && gml'

alias dsync_fang_dev='databricks_rsync --cluster_id=0908-215113-gages415'
alias dsync_fang_covid_breakfast='databricks_rsync --cluster_id=0217-021603-omakl0cg'
alias dsync_fang_basketball_dropout_wagyu_otw='databricks_rsync --cluster_id=0428-014503-j0kiirsb'
alias dsync_fang_the_feeling_erose_salt_mum_clothes='databricks_rsync --cluster_id=1113-130904-v48hwir8'

# alias put_fang_dev='python src/py/abnormal/deploy/databricks_tool.py upload_source_wheel -d fdeng -w aws_useast1'

alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'

alias cN='cd ~/notebooks'
alias cD='cd ~/Downloads'
# alias deploy_databricks='python src/py/abnormal/airflow/tools/airflow_tool.py deploy_to_databricks -w aws_useast1'

alias snotebook='cN && export PYSPARK_DRIVER_PYTHON=jupyter PYSPARK_DRIVER_PYTHON_OPTS='notebook' && pyspark && cs'

alias asl='aws sso login'

## Deprecated arc commands
# alias ad='arc lint && arc diff'
# alias al='arc land'

# IntelliJ Integrated Terminal
# bindkey "\e\eOD" backward-word
# bindkey "\e\eOC" forward-word

export ABNORMAL_USER=fdeng
export AWS_PROFILE=absec-mgmt

# Enable vi mode
# bindkey -v
# plugins=(
#   vi-mode
# )

# source /Users/dfs/flib/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh



##### emacs
# export PATH="$PATH:$HOME/.emacs.d/bin"

# My Scripts

# hola() {
#   local msg=${1:-'Done!'} title=${2:-'Long-running shell command'} sound=${3:-'Hero'}
#   osascript -e 'display notification "'"$msg"'" with title "'"$title"'" sound name "'"$sound"'"' -e 'activate application "iTerm2"'
# }

# alias dup="python $SOURCE/src/py/abnormal/fangs_notebooks/utils.py import_notebook -n"
# alias ddown="python $SOURCE/src/py/abnormal/fangs_notebooks/utils.py export_notebook -n"

# Script to read a folder containing both normal log files + gzipped log files
# expects the files to be in a folder named by a single integer e.g. 0
source ~/scripts/read_log.sh

# parses regular databricks output to copy the url
source ~/scripts/cp_databricks_url.sh

# Quality-Of-Life scripts for Git
source ~/scripts/git_scripts.sh

source ~/scripts/misc_scripts.sh

# Start the shell in the $SOURCE directory
cs
