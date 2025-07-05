{ config, lib, pkgs, ... }:

{
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.initContent
    initContent = 
      let 
        #zshConfigEarlyInit = lib.mkOrder 500 "Starting ZSH..."; 
        zshConfig = lib.mkOrder 1000 "fastfetch"; 
      in 
        lib.mkMerge [ 
          #zshConfigEarlyInit 
          zshConfig 
        ];

    shellAliases = {
      rebuild-nix = "sudo nixos-rebuild switch";
      upgrade-nix = "sudo nixos-rebuild switch --upgrade";
      watch-nvidia-smi = "watch -n 0.5 nvidia-smi";
    };
    
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
