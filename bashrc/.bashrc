#evaluations
eval "$(starship init bash)"
eval "$(~/my-setup-scripts/scripts/set-random-image-hyprlock.sh)"

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
alias stmux='tmux source-file ~/.tmux.conf'
alias update='sudo pacman -Sy'
alias snvim=' sudo nvim'
alias n='nvim'
PS1='[\u@\h \W]\$ '

#bindings
bind '"\C-f": "bash ~/my-setup-scripts/scripts/tmux-sessionizer.sh\n"'
bind '"\ef": "bash ~/my-setup-scripts/scripts/create-project.sh\n"'

#exports
export EDITOR=nvim
export GH_EDITOR=nvim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
export JAVA_HOME=/usr/lib/jvm/java-21-amazon-corretto
export PATH=$JAVA_HOME/bin:$PATH

#sources
if [ -f ~/.bashrc_secrets ]; then
  source ~/.bashrc_secrets
fi
source /usr/share/git/completion/git-completion.bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
# Load Angular CLI autocompletion.
source <(ng completion script)

neofetch

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Created by `pipx` on 2025-07-18 22:29:46
export PATH="$PATH:/home/mjerta/.local/bin"
