{ inputs, ... }:
{
  flake.modules.nixos.boot =
    { pkgs, lib, ... }:
    {
      imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
          efi.canTouchEfiVariables = true;
          systemd-boot.enable = lib.mkForce false;
          timeout = 0;
        };
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
          autoGenerateKeys.enable = true;
          autoEnrollKeys = {
            enable = true;
            autoReboot = true;
            includeFirmwareBuiltinKeys = true;
          };
        };
        plymouth = {
          enable = true;
          theme = "nixos-chase-glitch";
          themePackages = [inputs.nix-packages.packages.${pkgs.stdenv.hostPlatform.system}.plymouth-nixos-chase-glitch];
        };
        consoleLogLevel = 3;
        kernelParams = [
          "quiet"
          "splash"
          "rd.udev.log_level=3"
          "rd.systemd.show_status=auto"
        ];
      };

      environment.systemPackages = [ pkgs.sbctl ];
    };
}
