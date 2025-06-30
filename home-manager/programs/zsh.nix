{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update-nix = "sudo nixos-rebuild switch";
    };
    
    # autosuggestions.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "docker" ];
    };
  };

}

# Changin default compilers
#export CC=clang
#export CXX=clang++

# INTELLIJ
#export PATH=$PATH:/home/runior/Downloads/ideaIU-2025.1.2/idea-IU-251.26094.121/bin

# OBSIDIAN
#alias obsidian="/home/runior/Documents/obsidian/Obsidian-1.8.4.AppImage --no-sandbox"

# NVM - NODE VERSION MANAGER
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="$HOME/.sdkman"
#[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#eval "$(direnv hook zsh)"
