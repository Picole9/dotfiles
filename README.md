# dotfiles
My own configuration files.
* install for e.g. fish: `ln -sf /path/to/repo/fish/ ~/.config/fish`
* or install via ansible-repo

# wezterm
Configuration for wezterm-terminal
* weather-data from dwd
    * curl in windows does not build nativly with libz. install another one via e.g. `winget install curl.curl` first
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
* local override: `nvim/lua/plugins/override.lua` 
    * example adding php-language:
        ```lua
        return {
            {
                "nvim-treesitter/nvim-treesitter",
                opts = {
                    ensure_installed = {
                        "php"
                    }
                },
            },
            {
                "neovim/nvim-lspconfig",
                opts = {
                    servers = {
                        intelephense = {
                            settings = {
                                intelephense = {
                                    telemetry = {
                                        enabled = false
                                    }
                                }
                            }
                        },
                    }
                },
            },
        }
        ```

## nvim-legacy
simple configuration for old neovim

## conky
Configuration for customized desktop
