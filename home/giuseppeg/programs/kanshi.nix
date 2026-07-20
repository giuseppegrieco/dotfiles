{ ... }:

{
  services.kanshi = {
    enable = true;

    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.25;
            position = "0,0";
          }
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.25;
            position = "0,0";
          }
          {
            criteria = "Microstep MSI G32CQ4 E2";
            status = "enable";
            mode = "2560x1440";
            position = "1536,0";
            scale = 1.0;
          }
        ];
      }
    ];
  };
}
