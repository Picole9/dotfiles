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
config.window_background_opacity = 0.97

config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }

-- font
config.font = wezterm.font('DroidSansMono Nerd Font Mono', { weight = 'Regular' })
config.font_size = 13.0

config.scrollback_lines = 3500

-- statusline
wezterm.on('update-right-status', function(window, _)
    local cells = {}
    table.insert(cells, ' ' .. wezterm.strftime('%H:%M'))
    table.insert(cells, ' ' .. wezterm.strftime('%d.%m.%Y'))
    local discharging_icons =
      { '', '', '', '', '', '', '', '', '', '' }
    local charging_icons = { '', '', '', '', '', '', '', '', '', '' }
    local charge = ''
    local icon = ''
    local round = function(x, increment)
        if increment then
            return round(x / increment) * increment
        end
        return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
    end
    local clamp = function(x, min, max)
        return x < min and min or (x > max and max or x)
    end
    for _, b in ipairs(wezterm.battery_info()) do
        local idx = clamp(round(b.state_of_charge * 10), 1, 10)
        charge = string.format('%.0f%%', b.state_of_charge * 100)
        if b.state == "charging" then
            icon = charging_icons[idx]
        else
            icon = discharging_icons[idx]
        end
    end
    table.insert(cells, icon .. ' ' .. charge)

    local elements = {}
    local fg = '#c0c0c0'
    local bg = {
        '#A04000',
        '#873600',
        '#6E2C00',
    }
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    table.insert(elements, { Foreground = { Color = bg[1] }})
    table.insert(elements, { Text = SOLID_LEFT_ARROW })
    local id = 0
    local push = function(text, is_last)
        id = id + 1
        table.insert(elements, { Foreground = { Color = fg }})
        table.insert(elements, { Background = { Color = bg[id] }})
        table.insert(elements, { Text = '  ' .. text .. '  ' })
        if not is_last then
            table.insert(elements, { Foreground = { Color = bg[id + 1] }})
            table.insert(elements, { Text = SOLID_LEFT_ARROW})
        end
    end
    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push(cell, #cells == 0)
    end
    window:set_right_status(wezterm.format(elements))
end)
-- config.hide_tab_bar_if_only_one_tab = true

-- keybindings
config.leader = { key="a", mods="CTRL", timeout_milliseconds=1000 }
config.keys = {
    {key="Tab", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},
    {key="Tab", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=-1}},
    {key="f", mods="CTRL", action=wezterm.action{Search={Regex=""}}},
    {key="c", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="Clipboard"}},
    {key="v", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
    {key="h", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="v", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="LeftArrow", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="RightArrow", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="DownArrow", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="UpArrow", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="z", mods="LEADER", action="TogglePaneZoomState"},
    {key="q", mods="LEADER", action="QuickSelect"},
    {key="1", mods="LEADER", action=wezterm.action{ActivateTab=0}},
    {key="2", mods="LEADER", action=wezterm.action{ActivateTab=1}},
    {key="3", mods="LEADER", action=wezterm.action{ActivateTab=2}},
    {key="4", mods="LEADER", action=wezterm.action{ActivateTab=3}},
    {key="5", mods="LEADER", action=wezterm.action{ActivateTab=4}},
    {key="6", mods="LEADER", action=wezterm.action{ActivateTab=5}},
    {key="7", mods="LEADER", action=wezterm.action{ActivateTab=6}},
    {key="8", mods="LEADER", action=wezterm.action{ActivateTab=7}},
    {key="9", mods="LEADER", action=wezterm.action{ActivateTab=8}},
    {key="l", mods="LEADER", action="ActivateLastTab"},
    {key="t", mods="LEADER", action="ShowTabNavigator"},
    {key="n", mods="LEADER", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="c", mods="LEADER", action="ShowLauncher"},
    {key="r", mods="LEADER", action="ReloadConfiguration"},
    {key="x", mods="LEADER", action=wezterm.action{CloseCurrentPane={confirm=true}}},
}
-- os-specific
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
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
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then

end
-- and finally, return the configuration to wezterm
return config
