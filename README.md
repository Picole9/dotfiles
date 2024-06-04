# dotfiles
My own configuration files.
* install for e.g. fish: `ln -sf /path/to/repo/fish/ ~/.config/fish`
* or install via ansible-repo
* NOT MAINTAINED: install via `bash install.sh`

# wezterm
Configuration for wezterm-terminal
* openweathermap-integration: set env-variable `API_OWM={API_KEY}`
* leader \<Alt\>

## fish
Configuration for fishshell
* plugin-manager: fisher, usage `fisher install { repo }`, `fisher update`
* local fish-config, which is not uploaded: localconf.fish

## glow
Configuration for terminal markdown viewer
* usage: `glow { file }`

## nvim
Configuration for neovim-editor (nvim >= 0.10)
* leader \<Space\>
* lua-based
    * init.lua
    * lua/autocmds: neovim-autocommands
    * lua/keymaps: neovim-keymaps
    * lua/options: neovim-options
    * lua/plugins: plugins via lazy-pluginmanager

## conky
Configuration for customizing desktops
