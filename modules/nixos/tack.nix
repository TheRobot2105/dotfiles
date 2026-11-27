{
  flake.modules.nixos.tack = {
    config,...
  }:{
    programs.tack.enable = true;
  };
}