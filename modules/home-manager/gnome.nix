{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    desktop.gnome = {
      enable = lib.mkEnableOption "Enable Gnome settings";
    };
  };

  config = lib.mkIf config.desktop.gnome.enable {
    home.packages = with pkgs; [
      gnomeExtensions.vitals
      gnomeExtensions.hue-lights
      gnomeExtensions.tailscale-qs
      gnomeExtensions.unite
      gnomeExtensions.clipboard-indicator
      gnomeExtensions.keyboard-modifiers-status
      gnomeExtensions.another-window-session-manager
    ];

    dconf.settings = with lib.hm.gvariant; {
      "apps/seahorse/listing" = {
        keyrings-selected = ["openssh:///home/darth10/.ssh"];
      };

      "apps/seahorse/windows/key-manager" = {
        height = 476;
        width = 600;
      };

      "com/github/johnfactotum/Foliate" = {
        color-scheme = 0;
      };

      "com/github/johnfactotum/Foliate/viewer" = {
        fold-sidebar = true;
      };

      "com/github/johnfactotum/Foliate/viewer/view" = {
        invert = true;
      };

      "com/github/johnfactotum/Foliate/window" = {
        default-height = 736;
        maximized = true;
      };

      "org/gnome/Console" = {
        custom-font = "Consolas 16";
        last-window-maximised = true;
        last-window-size = mkTuple [652 480];
        use-system-font = false;
      };

      "org/gnome/Extensions" = {
        window-maximized = true;
      };

      "org/gnome/Loupe" = {
        show-properties = true;
      };

      "org/gnome/TextEditor" = {
        last-save-directory = "file:///home/darth10/.dot-nix";
      };

      "org/gnome/Totem" = {
        active-plugins = ["recent" "open-directory" "screenshot" "save-file" "screensaver" "mpris" "autoload-subtitles" "movie-properties" "variable-rate" "rotation" "skipto" "vimeo" "apple-trailers"];
        subtitle-encoding = "UTF-8";
      };

      "org/gnome/Weather" = {
        window-height = 496;
        window-maximized = false;
        window-width = 992;
      };

      "org/gnome/baobab/ui" = {
        active-chart = "rings";
        is-maximized = true;
      };

      "org/gnome/control-center" = {
        last-panel = "display";
        window-state = mkTuple [980 640 true];
      };

      "org/gnome/desktop/a11y/applications" = {
        screen-reader-enabled = false;
      };

      "org/gnome/desktop/a11y/keyboard" = {
        stickykeys-enable = false;
        stickykeys-two-key-off = false;
      };

      "org/gnome/desktop/a11y/magnifier" = {
        mag-factor = 3.0;
      };

      "org/gnome/desktop/app-folders" = {
        folder-children = ["Utilities" "YaST" "Pardus"];
      };

      "org/gnome/desktop/app-folders/folders/Pardus" = {
        categories = ["X-Pardus-Apps"];
        name = "X-Pardus-Apps.directory";
        translate = true;
      };

      "org/gnome/desktop/app-folders/folders/Utilities" = {
        apps = ["gnome-abrt.desktop" "gnome-system-log.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" "org.gnome.Connections.desktop" "org.gnome.DejaDup.desktop" "org.gnome.Dictionary.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" "org.gnome.FileRoller.desktop" "org.gnome.fonts.desktop" "org.gnome.Loupe.desktop" "org.gnome.seahorse.Application.desktop" "org.gnome.tweaks.desktop" "org.gnome.Usage.desktop" "vinagre.desktop"];
        categories = ["X-GNOME-Utilities"];
        name = "X-GNOME-Utilities.directory";
        translate = true;
      };

      "org/gnome/desktop/app-folders/folders/YaST" = {
        categories = ["X-SuSE-YaST"];
        name = "suse-yast.directory";
        translate = true;
      };

      "org/gnome/desktop/background" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///home/darth10/.local/share/backgrounds/nix-wallpaper-nineish-dark-gray.png";
        picture-uri-dark = "file:///home/darth10/.local/share/backgrounds/nix-wallpaper-nineish-dark-gray.png";
        primary-color = "#000000000000";
        secondary-color = "#000000000000";
      };

      "org/gnome/desktop/input-sources" = {
        sources = [(mkTuple ["xkb" "us"])];
        xkb-options = ["terminate:ctrl_alt_bksp"];
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-size = 24;
        cursor-theme = "Adwaita";
        enable-animations = true;
        enable-hot-corners = false;
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        font-name = "Cantarell 11";
        gtk-key-theme = "Default";
        gtk-theme = "Adwaita";
        icon-theme = "Adwaita";
        overlay-scrolling = true;
        show-battery-percentage = true;
        text-scaling-factor = 1.0;
        toolkit-accessibility = false;
      };

      "org/gnome/desktop/notifications" = {
        application-children = ["gnome-power-panel" "org-gnome-console" "firefox" "kitty" "veracrypt" "org-gnome-nautilus" "org-gnome-settings" "emacsclient" "spotify" "google-chrome" "transmission-gtk" "org-gnome-characters" "gnome-printers-panel" "org-gnome-loupe" "org-gnome-baobab" "pcloud"];
      };

      "org/gnome/desktop/notifications/application/emacsclient" = {
        application-id = "emacsclient.desktop";
      };

      "org/gnome/desktop/notifications/application/firefox" = {
        application-id = "firefox.desktop";
      };

      "org/gnome/desktop/notifications/application/gnome-power-panel" = {
        application-id = "gnome-power-panel.desktop";
      };

      "org/gnome/desktop/notifications/application/gnome-printers-panel" = {
        application-id = "gnome-printers-panel.desktop";
      };

      "org/gnome/desktop/notifications/application/google-chrome" = {
        application-id = "google-chrome.desktop";
      };

      "org/gnome/desktop/notifications/application/kitty" = {
        application-id = "kitty.desktop";
      };

      "org/gnome/desktop/notifications/application/org-gnome-baobab" = {
        application-id = "org.gnome.baobab.desktop";
      };

      "org/gnome/desktop/notifications/application/org-gnome-characters" = {
        application-id = "org.gnome.Characters.desktop";
      };

      "org/gnome/desktop/notifications/application/org-gnome-console" = {
        application-id = "org.gnome.Console.desktop";
      };

      "org/gnome/desktop/notifications/application/org-gnome-loupe" = {
        application-id = "org.gnome.Loupe.desktop";
      };

      "org/gnome/desktop/notifications/application/org-gnome-nautilus" = {
        application-id = "org.gnome.Nautilus.desktop";
      };

      "org/gnome/desktop/notifications/application/org-gnome-settings" = {
        application-id = "org.gnome.Settings.desktop";
      };

      "org/gnome/desktop/notifications/application/pcloud" = {
        application-id = "pcloud.desktop";
      };

      "org/gnome/desktop/notifications/application/spotify" = {
        application-id = "spotify.desktop";
      };

      "org/gnome/desktop/notifications/application/transmission-gtk" = {
        application-id = "transmission-gtk.desktop";
      };

      "org/gnome/desktop/notifications/application/veracrypt" = {
        application-id = "veracrypt.desktop";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = false;
        speed = -0.33834586466165417;
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "file:///home/darth10/.local/share/backgrounds/nix-wallpaper-nineish-dark-gray.png";
        primary-color = "#000000000000";
        secondary-color = "#000000000000";
      };

      "org/gnome/desktop/search-providers" = {
        sort-order = ["org.gnome.Contacts.desktop" "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop"];
      };

      "org/gnome/desktop/wm/keybindings" = {
        activate-window-menu = ["<Super>period"];
        begin-move = ["<Super>m"];
        begin-resize = ["<Super>r"];
        close = ["<Super>q"];
        cycle-group = ["<Super>F6"];
        cycle-group-backward = ["<Shift><Super>F6"];
        cycle-windows = ["<Super>Escape"];
        cycle-windows-backward = ["<Shift><Super>Escape"];
        maximize-horizontally = ["<Alt><Super>equal"];
        maximize-vertically = ["<Shift><Alt><Super>equal"];
        panel-run-dialog = ["<Super>F2"];
        switch-input-source = [];
        switch-input-source-backward = [];
        toggle-maximized = ["<Alt><Super>F10"];
      };

      "org/gnome/epiphany" = {
        ask-for-default = false;
      };

      "org/gnome/epiphany/state" = {
        is-maximized = false;
        window-size = mkTuple [1024 736];
      };

      "org/gnome/evince/default" = {
        continuous = true;
        dual-page = false;
        dual-page-odd-left = false;
        enable-spellchecking = true;
        fullscreen = false;
        inverted-colors = false;
        show-sidebar = true;
        sidebar-page = "thumbnails";
        sidebar-size = 132;
        sizing-mode = "automatic";
        window-ratio = mkTuple [1.0079358146473232 0.7126821793821045];
      };

      "org/gnome/evolution-data-server" = {
        migrated = true;
      };

      "org/gnome/file-roller/listing" = {
        list-mode = "as-folder";
        name-column-width = 65;
        show-path = false;
        sort-method = "name";
        sort-type = "ascending";
      };

      "org/gnome/file-roller/ui" = {
        sidebar-width = 200;
        window-height = 480;
        window-width = 600;
      };

      "org/gnome/gnome-system-monitor" = {
        current-tab = "resources";
        maximized = true;
        show-dependencies = false;
        show-whose-processes = "user";
      };

      "org/gnome/gnome-system-monitor/disktreenew" = {
        col-6-visible = true;
        col-6-width = 0;
      };

      "org/gnome/gnome-system-monitor/proctree" = {
        columns-order = [0 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26];
        sort-col = 15;
        sort-order = 0;
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        overlay-key = "";
      };

      "org/gnome/mutter/wayland/keybindings" = {
        restore-shortcuts = [];
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
      };

      "org/gnome/nautilus/window-state" = {
        initial-size = mkTuple [890 550];
        initial-size-file-chooser = mkTuple [890 550];
        maximized = true;
      };

      "org/gnome/nm-applet/eap/8a6e1d5a-fce7-432c-8205-1b7a26fb7040" = {
        ignore-ca-cert = false;
        ignore-phase2-ca-cert = false;
      };

      "org/gnome/nm-applet/eap/b82fe183-e4fa-4542-b2d2-37feff026552" = {
        ignore-ca-cert = false;
        ignore-phase2-ca-cert = false;
      };

      "org/gnome/portal/filechooser/com/github/johnfactotum/Foliate" = {
        last-folder-path = "/home/darth10/pCloudDrive/lib/[other]";
      };

      "org/gnome/portal/filechooser/google-chrome" = {
        last-folder-path = "/home/darth10/pCloudDrive/code";
      };

      "org/gnome/portal/filechooser/org/gnome/Settings" = {
        last-folder-path = "/home/darth10/Downloads";
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-schedule-automatic = false;
        night-light-temperature = mkUint32 3700;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
        help = [];
        logout = [];
        magnifier-zoom-in = [];
        screensaver = ["<Control><Super>q"];
        search = ["<Super>space"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "kitty htop";
        name = "htop";
      };

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-battery-type = "nothing";
      };

      "org/gnome/shell" = {
        command-history = ["virt-manager" "emacs"];
        disable-extension-version-validation = true;
        disabled-extensions = ["workspace-indicator@gnome-shell-extensions.gcampax.github.com" "places-menu@gnome-shell-extensions.gcampax.github.com"];
        enabled-extensions = ["hue-lights@chlumskyvaclav.gmail.com" "unite@hardpixel.eu" "keyboard_modifiers_status@sneetsher" "spotify-controller@koolskateguy89" "another-window-session-manager@gmail.com" "tailscale@joaophi.github.com" "Vitals@CoreCoding.com" "clipboard-indicator@tudmotu.com"];
        favorite-apps = ["emacsclient.desktop" "google-chrome.desktop" "firefox.desktop" "spotify.desktop" "org.gnome.Nautilus.desktop" "kitty.desktop"];
        last-selected-power-profile = "power-saver";
        welcome-dialog-last-shown-version = "46.2";
      };

      "org/gnome/shell/extensions/another-window-session-manager" = {
        autorestore-sessions = "default";
        autorestore-sessions-timer = 3;
        enable-autoclose-session = false;
        enable-autorestore-sessions = true;
        enable-close-by-rules = false;
        enable-restore-previous-session = false;
        enable-save-session-notification = false;
        restore-previous-delay = 3;
        show-indicator = true;
        windows-mapping = "[[\"Unknown\",{\"W56 ([untitled])\":{\"windowTitle\":null,\"xid\":\"W56 ([untitled])\",\"windowStableSequence\":57}}],[\"/run/current-system/sw/share/applications/org.gnome.Settings.desktop\",{\"W2 ([untitled])\":{\"windowTitle\":null,\"xid\":\"W2 ([untitled])\",\"windowStableSequence\":3}}],[\"/run/current-system/sw/share/applications/emacsclient.desktop\",{\"0xe041d7 ([untitled])\":{\"windowTitle\":null,\"xid\":\"0xe041d7 ([untitled])\",\"windowStableSequence\":18}}],[\"/run/current-system/sw/share/applications/google-chrome.desktop\",{\"0x100007c ()\":{\"windowTitle\":\"\",\"xid\":\"0x100007c ()\",\"windowStableSequence\":47}}],[\"/nix/store/qcajaw2qc9kk13fc4jqxgik64da1v0ig-gnome-shell-47.4/share/applications/org.gnome.Shell.Extensions.desktop\",{\"W61 ([untitled])\":{\"windowTitle\":null,\"xid\":\"W61 ([untitled])\",\"windowStableSequence\":62}}],[\"/run/current-system/sw/share/applications/org.gnome.Nautilus.desktop\",{\"W16 ([untitled])\":{\"windowTitle\":null,\"xid\":\"W16 ([untitled])\",\"windowStableSequence\":17}}],[\"/run/current-system/sw/share/applications/pcloud.desktop\",{\"0xc00008 (pcloud)\":{\"windowTitle\":\"pcloud\",\"xid\":\"0xc00008 (pcloud)\",\"windowStableSequence\":30}}],[\"/run/current-system/sw/share/applications/veracrypt.desktop\",{\"W47 ([untitled])\":{\"windowTitle\":null,\"xid\":\"W47 ([untitled])\",\"windowStableSequence\":48}}],[\"/run/current-system/sw/share/applications/vlc.desktop\",{\"0x1a0004b (vlc)\":{\"windowTitle\":\"vlc\",\"xid\":\"0x1a0004b (vlc)\",\"windowStableSequence\":55}}]]";
      };

      "org/gnome/shell/extensions/clipboard-indicator" = {
        disable-down-arrow = true;
        history-size = 100;
        preview-size = 10;
        toggle-menu = ["<Shift><Super>c"];
        topbar-preview-size = 15;
      };

      "org/gnome/shell/extensions/hue-lights" = {
        connection-timeout = 2;
        connection-timeout-sb = 8;
        icon-pack = "bright";
        indicator-position = "right";
        show-scenes = true;
      };

      "org/gnome/shell/extensions/unite" = {
        app-menu-ellipsize-mode = "start";
        autofocus-windows = false;
        enable-titlebar-actions = false;
        extend-left-box = false;
        hide-activities-button = "never";
        hide-app-menu-icon = false;
        hide-window-titlebars = "both";
        reduce-panel-spacing = false;
        restrict-to-primary-screen = false;
        show-appmenu-button = false;
        show-desktop-name = false;
        show-legacy-tray = false;
        show-window-buttons = "never";
        show-window-title = "always";
        use-activities-text = false;
      };

      "org/gnome/shell/extensions/vitals" = {
        alphabetize = true;
        fixed-widths = true;
        hide-icons = false;
        hot-sensors = ["_temperature_acpi_thermal zone_" "_memory_usage_"];
        icon-style = 0;
        menu-centered = false;
        position-in-panel = 0;
        show-battery = false;
        show-network = true;
        show-voltage = true;
        update-time = 3;
        use-higher-precision = false;
      };

      "org/gnome/shell/keybindings" = {
        screenshot = ["<Shift><Super>3"];
        screenshot-window = ["<Shift><Super>4"];
        show-screen-recording-ui = [];
        show-screenshot-ui = ["<Shift><Super>5"];
        toggle-message-tray = [];
        toggle-quick-settings = ["<Control><Super>s"];
      };

      "org/gnome/shell/weather" = {
        automatic-location = true;
      };

      "org/gnome/shell/world-clocks" = {
        locations = [];
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        date-format = "regular";
        location-mode = "path-bar";
        show-hidden = false;
        sidebar-width = 140;
        sort-column = "name";
        sort-directories-first = true;
        sort-order = "ascending";
        type-format = "category";
        view-type = "list";
        window-size = mkTuple [859 372];
      };

      "org/gtk/settings/file-chooser" = {
        date-format = "regular";
        location-mode = "path-bar";
        show-hidden = false;
        show-size-column = true;
        show-type-column = true;
        sidebar-width = 166;
        sort-column = "name";
        sort-directories-first = false;
        sort-order = "ascending";
        type-format = "category";
        window-position = mkTuple [26 23];
        window-size = mkTuple [1366 689];
      };

      "org/virt-manager/virt-manager" = {
        manager-window-height = 1048;
        manager-window-width = 1920;
        xmleditor-enabled = true;
      };

      "org/virt-manager/virt-manager/confirm" = {
        forcepoweroff = true;
        removedev = true;
      };

      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };

      "org/virt-manager/virt-manager/conns/qemu:system" = {
        window-size = mkTuple [800 600];
      };

      "org/virt-manager/virt-manager/details" = {
        show-toolbar = true;
      };

      "org/virt-manager/virt-manager/new-vm" = {
        graphics-type = "system";
      };

      "org/virt-manager/virt-manager/urls" = {
        isos = ["/data/downlink/nixos-gnome-24.05.4974.8f7492cce289-x86_64-linux.iso" "/data/downlink/manjaro-xfce-24.0.7-minimal-240821-linux69.iso"];
      };

      "org/virt-manager/virt-manager/vmlist-fields" = {
        disk-usage = false;
        network-traffic = false;
      };

      "org/virt-manager/virt-manager/vms/ddcf5781e3ff4e71b49477e74b427d12" = {
        autoconnect = 1;
        scaling = 1;
        vm-window-size = mkTuple [1366 736];
      };

      "org/virt-manager/virt-manager/vms/f7d6c2f36ae34ed19b2960df5b0fb286" = {
        autoconnect = 1;
        scaling = 1;
        vm-window-size = mkTuple [1920 1048];
      };
    };
  };
}
