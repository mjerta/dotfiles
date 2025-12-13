#evaluations
eval "$(starship init bash)"
if [ -z "$WSL_DISTRO_NAME" ]; then
  eval "$(~/my-setup-scripts/scripts/set-random-image-hyprlock.sh)"
else
  source ~/.bashrc-windows
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#functions
http_request_handler() {
  ~/my-setup-scripts/scripts/http-request-handler.sh "$@"
}
export -f http_request_handler

#aliases
alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
alias wifi='nmtui'
alias ai='~/my-setup-scripts/scripts/ai.sh'
alias openai-tokens='~/my-setup-scripts/scripts/check-ai-tokens.sh'
alias githublink='~/my-setup-scripts/scripts/githublink.sh'
alias githubrepo='~/my-setup-scripts/scripts/creategithubrepo.sh'
alias githubclone='~/my-setup-scripts/scripts/githubclone.sh'
alias springboot='~/my-setup-scripts/scripts/springboot.sh'
alias maven='~/my-setup-scripts/scripts/maven.sh'
alias maven-quickstart='~/my-setup-scripts/scripts/maven-quickstart.sh'
alias deploy-maven='~/my-setup-scripts/scripts/deploy-maven.sh'
alias spring-handy='~/my-setup-scripts/scripts/create-ntier-architecture-spring.sh'
alias scan='~/my-setup-scripts/scripts/scan.sh'
alias tmux-sessionizer='~/my-setup-scripts/scripts/tmux-sessionizer.sh'
alias compress-pdf='~/my-setup-scripts/scripts/compress-pdf.sh'
alias open-meteo='~/my-setup-scripts/scripts/open-meteo.sh'
alias .='cd ..'
alias ..='cd ../../'
alias ...='cd ../../../'
alias dotfiles='cd ~/dotfiles'
alias mpdev='ssh root@mpdev.nl'
alias thinkcentre='ssh root@thinkcentre.mpdev.nl'
alias bashrc='nvim ~/.bashrc'
alias sbashrc='source ~/.bashrc'
alias bashrc-secrets='nvim ~/.bashrc_secrets'
alias stmux='tmux source-file ~/.tmux.conf'
alias update='sudo pacman -Sy'
alias snvim=' sudo nvim'
alias n='nvim'
alias ps='powershell.exe'
alias magic-dev='cd /mnt/d/magic-dev-environments/Trade/Env/'
alias winlocal='cd /mnt/c/Users/mpostma/Appdata/Local/'
PS1='[\u@\h \W]\$ '

#bindings
bind '"\C-f": "bash ~/my-setup-scripts/scripts/tmux-sessionizer.sh\n"'
bind '"\ef": "bash ~/my-setup-scripts/scripts/create-project.sh\n"'

#exports
if [ -z "$WSL_DISTRO_NAME" ]; then
  export DEVELOP=~/develop/
else
  export DEVELOP=/mnt/d/develop/
fi
export EDITOR=nvim
export GH_EDITOR=nvim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
export JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto
export PATH=$JAVA_HOME/bin:$PATH
# Default starting with lazy
export NVIM_APPNAME="nvim-lazy"
nvs() {
  if [ -z "$1" ]; then
    echo "Usage: nvs <profile>"
    echo "Example: nvs main  OR  nvs lazy"
    return 1
  fi
  export NVIM_APPNAME="nvim-$1"
  nvim "${@:2}"
}

#sources
if [ -f ~/.bashrc_secrets ]; then
  source ~/.bashrc_secrets
fi
source /usr/share/git/completion/git-completion.bash
if [ -z "$WSL_DISTRO_NAME" ]; then
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
# Load Angular CLI autocompletion.
if ng completion --help >/dev/null 2>&1; then
  source <(ng completion script)
fi

# Turned off due to perfomance issues
# neofetch

# Created by `pipx` on 2025-07-18 22:29:46
export PATH="$PATH:/home/mjerta/.local/bin"

# opencode
export PATH=/home/mjerta/.opencode/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
if [ -z "$WSL_DISTRO_NAME" ]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
