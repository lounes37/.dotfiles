source ~/.cache/starship/init.nu
source ~/.cache/.zoxide.nu

$env.config = {
    show_banner: false,
    completions: {
        algorithm: "fuzzy"
    },
    keybindings: [
        {
            name: atuin
            modifier: control
            keycode: char_r
            mode: [emacs, vi_normal, vi_insert]
            event: { send: executehostcommand cmd: (_atuin_search_cmd) }
        }
    ]
}