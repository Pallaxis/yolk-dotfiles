export let data = #{
    is_nvidia: if SYSTEM.hostname == "night" { true } else { false }
};

export let eggs = #{
    alacritty: "~/.config/alacritty/",
    bat: "~/.config/bat/",
    btop: "~/.config/btop/",
    fastfetch: "~/.config/fastfetch/",
    hypr: #{ targets: "~/.config/hypr/", templates: [ "settings/windowrules.conf" ] },
    kitty: "~/.config/kitty/",
    nvim: "~/.config/nvim/",
    qt5ct: "~/.config/qt5ct/",
    rofi: "~/.config/rofi/",
    systemd: #{ targets: #{ ".": "~/.config/systemd/user/" }, strategy: "merge" },
    tio: "~/.config/tio/",
    tmux: "~/.config/tmux/",
    xdg: #{ targets: #{ "user-dirs.dirs": "~/.config/user-dirs.dirs" }, },
    uwsm: #{ targets: "~/.config/uwsm/", templates: [ "env" ] },
    waybar: "~/.config/waybar/",
    wlogout: "~/.config/wlogout/",
    zsh: #{ targets: #{ ".zshrc": "~/.zshrc" }, },
};
