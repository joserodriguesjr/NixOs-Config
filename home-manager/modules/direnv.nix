{
  programs.direnv ={
    enable = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;

    config = {
      whitelist = {
        prefix = [ "~/Code" ];
      };
    };

  };
}

# Example
#{ 
#  pkgs ? import <nixpkgs> { }
#}:
#pkgs.mkShell {
#  name = "dev-environment"; # that requires a name
#  packages = [
#    pkgs.rustc
#  ];
#  shellHook = ''
#    # bash to run when you enter the shell
#    echo "Start developing..."
#  '';
#}