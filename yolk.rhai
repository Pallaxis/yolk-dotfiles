export let data = #{
    is_nvidia: if SYSTEM.hostname == "night" { true } else { false }
};

export let eggs = #{
    alacritty: "~/.config/alacritty/",
    bat: "~/.config/bat/",
    bin: #{ targets: "~/.local/bin/", strategy: "merge" },
    btop: "~/.config/btop/",
    dunst: "~/.config/dunst/",
    fastfetch: "~/.config/fastfetch/",
    hypr: #{ targets: "~/.config/hypr/", templates: [ "settings/windowrules.conf" ] },
    kitty: "~/.config/kitty/",
    nvim: "~/.config/nvim/",
    rofi: "~/.config/rofi/",
    share: #{ targets: #{ "rofi" : "~/.local/share/rofi", }, },
    systemd: #{ targets: "~/.config/systemd/user/", strategy: "merge" },
    tio: "~/.config/tio/",
    tmux: "~/.config/tmux/",
    xdg: #{ targets: #{ "user-dirs.dirs": "~/.config/user-dirs.dirs" }, },
    uwsm: #{ targets: "~/.config/uwsm/", templates: [ "env" ] },
    wallpapers: "~/.local/share/wallpapers/",
    waybar: "~/.config/waybar/",
    wlogout: "~/.config/wlogout/",
    zsh: #{ targets: #{ ".zshrc": "~/.zshrc" }, templates: [ ".zshrc" ] },
};
