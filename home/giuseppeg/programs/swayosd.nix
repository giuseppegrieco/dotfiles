{ config, pkgs, ... }:

{
  services.swayosd = {
    enable = true;

    stylePath =
      let
        c = config.lib.stylix.colors.withHashtag;
      in
      pkgs.writeText "swayosd-style.css" ''
        window {
          background: ${c.base00};
          border: 2px solid ${c.base0D};
          border-radius: 12px;
        }
        label, image { color: ${c.base05}; }
        progressbar { min-height: 6px; }
        progressbar trough { background: ${c.base02}; border-radius: 6px; }
        progressbar progress { background: ${c.base0D}; border-radius: 6px; }
      '';
  };
}
