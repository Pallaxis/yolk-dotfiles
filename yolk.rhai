export let data = #{
    is_nvidia: if SYSTEM.hostname == "night" { true } else { false }
};

export let eggs = #{
    alacritty: "~/.config/alacritty/",
    applications: #{ targets: "~/.local/share/applications/", strategy: "merge" },
    bat: "~/.config/bat/",
    bin: #{ targets: "~/.local/bin/", strategy: "merge" },
    btop: "~/.config/btop/",
    dunst: "~/.config/dunst/",
    extras: #{ enabled: false },
    fastfetch: "~/.config/fastfetch/",
    hypr: #{ targets: "~/.config/hypr/", templates: [ "hyprland-settings/windowrules.conf", "hyprland-settings/env.conf" ] },
    kitty: "~/.config/kitty/",
    nvim: "~/.config/nvim/",
    qt5ct: "~/.config/qt5ct/",
    qt6ct: "~/.config/qt6ct/",
    qutebrowser: #{
        targets: #{
            "config.py": "~/.config/qutebrowser/config.py",
            "slack-annoyances.js": "~/.local/share/qutebrowser/greasemonkey/slack-annoyances.js",
        },
    },
    rofi: "~/.config/rofi/",
    systemd: #{ targets: "~/.config/systemd/user/", strategy: "merge" },
    tealdeer: "~/.config/tealdeer/",
    tio: "~/.config/tio/",
    tmux: "~/.config/tmux/",
    udiskie: "~/.config/udiskie/",
    xdg: #{ targets: #{ "user-dirs.dirs": "~/.config/user-dirs.dirs" }, },
    uwsm: #{ targets: "~/.config/uwsm/", templates: [ "env" ] },
    wallpapers: "~/.local/share/wallpapers/",
    waybar: "~/.config/waybar/",
    wlogout: "~/.config/wlogout/",
    zsh: #{ targets: #{ ".zshrc": "~/.zshrc" }, },
};
