# dotfiles
My own configuration files.
* install for e.g. fish: `ln -sf /path/to/repo/fish/ ~/.config/fish`
* or install via ansible-repo
* NOT MAINTAINED: install via `bash install.sh`

## fish
Configuration for fishshell
* plugin-manager: fisher, usage `fisher install { repo }`, `fisher update`

## glow
Configuration for terminal markdown viewer
* usage: `glow { file }`

## nvim
Configuration for neovim-editor
* lua-based
    * init.lua
    * lua/autocmds: neovim-autocommands
    * lua/keymaps: neovim-keymaps
    * lua/options: neovim-options
    * lua/plugins: plugins via lazy-pluginmanager
