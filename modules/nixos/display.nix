{pkgs, ...}: {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "nz";
        variant = "";
      };
    };

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  systemd.tmpfiles.rules = [
    # This should all be copied from ~/.config/monitors.xml:
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" ''
      <monitors version="2">
        <configuration>
          <layoutmode>logical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>VGA-1</connector>
                <vendor>BNQ</vendor>
                <product>BenQ BL2480T</product>
                <serial>31N0698801Q</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <disabled>
            <monitorspec>
              <connector>LVDS-1</connector>
              <vendor>LGD</vendor>
              <product>0x03b1</product>
              <serial>0x00000000</serial>
            </monitorspec>
          </disabled>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>VGA-1</connector>
                <vendor>BNQ</vendor>
                <product>BenQ BL2480T</product>
                <serial>31N0698801Q</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <disabled>
            <monitorspec>
              <connector>LVDS-1</connector>
              <vendor>LGD</vendor>
              <product>0x03b1</product>
              <serial>0x00000000</serial>
            </monitorspec>
          </disabled>
        </configuration>
        <configuration>
          <layoutmode>physical</layoutmode>
          <logicalmonitor>
            <x>0</x>
            <y>0</y>
            <scale>1</scale>
            <primary>yes</primary>
            <monitor>
              <monitorspec>
                <connector>VGA-1</connector>
                <vendor>BNQ</vendor>
                <product>BenQ BL2480T</product>
                <serial>31N0698801Q</serial>
              </monitorspec>
              <mode>
                <width>1920</width>
                <height>1080</height>
                <rate>60.000</rate>
              </mode>
            </monitor>
          </logicalmonitor>
          <disabled>
            <monitorspec>
              <connector>LVDS-1</connector>
              <vendor>LGD</vendor>
              <product>0x03a3</product>
              <serial>0x00000000</serial>
            </monitorspec>
          </disabled>
        </configuration>
      </monitors>
    ''}"
  ];
}
