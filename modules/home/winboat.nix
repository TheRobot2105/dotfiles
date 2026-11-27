# WinBoat: Windows-Apps über einen Docker-Container (KVM) + FreeRDP.
# Benötigt Docker und die Gruppe "docker" (siehe ../nixos/virtualisation.nix).
{
  flake.modules.homeManager.winboat =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.winboat ];
    };
}
