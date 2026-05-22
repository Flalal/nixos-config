{ pkgs, ... }:
{
  services.swayosd = {
    enable = true;
    topMargin = 0.85;
  };

  home.packages = [ pkgs.swayosd ];
}
