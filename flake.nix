{
  description = "NixOS-Konfiguration (Dendritic Pattern)";

  nixConfig = {
    extra-substituters = [
      "https://therobot2105.cachix.org"
    ];
    extra-trusted-public-keys = [
      "therobot2105.cachix.org-1:RX3o93UfxJFGbsvHxthPnVYAs2FnL7H6V7N9VUh4AnQ="
    ];
  };

  # Alle Inputs außer wallpaper werden über tack verwaltet (.tack/pins.toml).
  # wallpaper bleibt ein Flake-Input, weil tack kein Git-LFS unterstützt.
  inputs = {
    wallpaper = {
      type = "git";
      url = "ssh://git@github.com/therobot2105/wallpaper";
      lfs = true;
      flake = false;
    };
  };

  # Dendritic Pattern: Jede Datei unter ./modules ist ein flake-parts-Modul.
  outputs =
    { self, wallpaper, ... }@args:
    let
      inputs = (import ./.tack) { overrides = args.tackOverrides or { }; } // {
        inherit self wallpaper;
      };
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
