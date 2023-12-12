-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- colorscheme
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.window_background_opacity = 0.95

-- font
config.font = wezterm.font 'DroidSansMono Nerd Font Mono'
config.font_size = 13.0

-- domain
config.default_domain = 'WSL:Ubuntu'
config.launch_menu = {
    {
        label = 'Ubuntu',
        args = {
            'wsl.exe',
            '-d',
            'Ubuntu'
        }
    },
    {
        label = 'Powershell',
        args = {
            'powershell.exe'
        }
    },
    {
        label = 'cmd',
        args = {
            'cmd.exe'
        }
    },
}
-- and finally, return the configuration to wezterm
return config
