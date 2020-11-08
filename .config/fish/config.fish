# My fish config.
set -U fish_user_paths $fish_user_paths $HOME/.local/bin/
set fish_greeting                      # Supresses fish's intro message
set TERM "xterm-256color"              # Sets the terminal type
set EDITOR "emacsclient -t -a ''"      # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"   # $VISUAL use Emacs in GUI mode

### Prompt ###
# This wos the 'fishface' prompt from oh-my-fish.
function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l 62A (set_color 62A)
  set -l 62A (set_color 62A)

  if [ (_git_branch_name) ]
    echo -n -s "$62A><(((\"> "
  else
    echo -n -s "$62A><(((\"> "
  end
end
### END OF PROMPT ###

### DEFAULT EMACS MODE ###
function fish_user_key_bindings
  fish_default_key_bindings
  # fish_vi_key_bindings
end
### END OF EMACS MODE ###

### FUNCTIONS ###
# Functions needed for !! and !$
# Will only work in default (emacs) mode.
# Will NOT work in vi mode.
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
bind ! __history_previous_command
bind '$' __history_previous_command_arguments
### END OF FUNCTIONS ###

### ALIASES ###
alias dotfile='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
