export let data = #{
/*
    for_vcs: LOCAL,
    cool_setting: if SYSTEM.hostname == "foo" { 10 } else { 25 }
*/
};
export let eggs = #{
    alacritty: "~/.config/alacritty/",
    bat: "~/.config/bat/",
    btop: "~/.config/btop/",
    fastfetch: "~/.config/fastfetch/",
    hypr: "~/.config/hypr/",
    kitty: "~/.config/kitty/",
    nvim: "~/.config/nvim/",
    qt5ct: "~/.config/qt5ct/",
    rofi: "~/.config/rofi/",
    tio: "~/.config/tio/",
    tmux: "~/.config/tmux/",
    uwsm: "~/.config/uwsm/",
    waybar: "~/.config/waybar/",
    wlogout: "~/.config/wlogout/",
};

/* Example of eggs config section
export let eggs = #{
    alacritty: #{
        targets: "~/.config/alacritty/",
        templates: [],
        enabled: false
    }
};
*/
