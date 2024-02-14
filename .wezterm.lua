-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- functions
local function basename(s)
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
end
local round = function(x, increment)
    if increment then
        return round(x / increment) * increment
    end
    return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end
local clamp = function(x, min, max)
    return x < min and min or (x > max and max or x)
end
local darken = function(color, darkness)
    local red = tonumber(color:sub(2,3), 16)
    local green = tonumber(color:sub(4,5), 16)
    local blue = tonumber(color:sub(6,7), 16)
    red = math.floor(red * darkness)
    green = math.floor(green * darkness)
    blue = math.floor(blue * darkness)
    return string.format("#%02X%02X%02X", red, green, blue)
end

-- This is where you actually apply your config choices

-- colorscheme
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.window_background_opacity = 0.97

-- font
config.font = wezterm.font('Hasklug Nerd Font', { weight = 'Regular' })
config.font_size = 13.0

-- other
config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }
config.scrollback_lines = 3500
config.adjust_window_size_when_changing_font_size = false
config.default_prog = { '/usr/bin/fish', '-l' }
-- config.hide_tab_bar_if_only_one_tab = true

-- statusline
wezterm.on('update-right-status', function(window, _)
    -- define elements per cell
    local cells = {}
    table.insert(cells, '  ' .. wezterm.strftime('%H:%M'))
    table.insert(cells, 'KW: ' .. wezterm.strftime('%V'))
    table.insert(cells, '  ' .. wezterm.strftime('%d.%m.%Y'))
    local discharging_icons =
      { '󰂃', '󰁺', '󰁻', '󰁼', '󰁽', '󰁾', '󰁿', '󰂀', '󰂁', '󰁹' }
    local charging_icons = { '󰂃', '󰢜', '󰂆', '󰂇', '󰂈', '󰢝', '󰂉', '󰢞', '󰂊', '󰂋' }
    local charge = ''
    local icon = ''
    for _, b in ipairs(wezterm.battery_info()) do
        local idx = clamp(round(b.state_of_charge * 10), 1, 10)
        charge = string.format('%.0f%%', b.state_of_charge * 100)
        if b.state == "Charging" then
            icon = charging_icons[idx]
        else
            icon = discharging_icons[idx]
        end
        table.insert(cells, icon .. ' ' .. charge)
    end
    -- print all cells
    local elements = {}
    local fg = '#c0c0c0'
    local bg_start = "#ba4a00"
    local bg = {}
    for i=0,10 do
        bg[i] = darken(bg_start, 1-(i/10.0))
    end
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

local SUP_IDX = {"¹","²","³","⁴","⁵","⁶","⁷","⁸","⁹","¹⁰",
                 "¹¹","¹²","¹³","¹⁴","¹⁵","¹⁶","¹⁷","¹⁸","¹⁹","²⁰"}
wezterm.on(
    'format-tab-title',
    function(tab, _, _, _, _, max_width)
        local title = tab.tab_title
        if not title or #title == 0 then
            title = tab.active_pane.title
        end
        local icon
        local exec_name = basename(tab.active_pane.foreground_process_name)
        if exec_name == "wsl.exe" or exec_name == "wslhost.exe" then
            icon = ""
        elseif exec_name == "powershell.exe" then
            icon = ""
        elseif exec_name == "cmd.exe" then
            icon = ""
        else
            icon = ""
        end
        title = wezterm.truncate_right(' ' .. SUP_IDX[tab.tab_index+1] .. icon .. '  ' .. title .. ' ', max_width - 2)
        return {
            { Text =  title },
        }
    end
)

-- keybindings
config.leader = { key="a", mods="CTRL", timeout_milliseconds=1000 }
config.keys = {
    {key="Tab", mods="CTRL", action=wezterm.action{ActivateTabRelative=1}},
    {key="Tab", mods="CTRL|SHIFT", action=wezterm.action{ActivateTabRelative=-1}},
    {key="f", mods="CTRL", action=wezterm.action{Search={Regex=""}}},
    {key="c", mods="CTRL|SHIFT", action=wezterm.action{CopyTo="Clipboard"}},
    {key="v", mods="CTRL|SHIFT", action=wezterm.action{PasteFrom="Clipboard"}},
    {key="h", mods="ALT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="v", mods="ALT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="LeftArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="RightArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="DownArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="UpArrow", mods="ALT", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="z", mods="ALT", action="TogglePaneZoomState"},
    {key="q", mods="ALT", action="QuickSelect"},
    {key="1", mods="ALT", action=wezterm.action{ActivateTab=0}},
    {key="2", mods="ALT", action=wezterm.action{ActivateTab=1}},
    {key="3", mods="ALT", action=wezterm.action{ActivateTab=2}},
    {key="4", mods="ALT", action=wezterm.action{ActivateTab=3}},
    {key="5", mods="ALT", action=wezterm.action{ActivateTab=4}},
    {key="6", mods="ALT", action=wezterm.action{ActivateTab=5}},
    {key="7", mods="ALT", action=wezterm.action{ActivateTab=6}},
    {key="8", mods="ALT", action=wezterm.action{ActivateTab=7}},
    {key="9", mods="ALT", action=wezterm.action{ActivateTab=8}},
    {key="l", mods="ALT", action="ActivateLastTab"},
    {key="t", mods="ALT", action="ShowTabNavigator"},
    {key="n", mods="ALT", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    {key="c", mods="ALT", action="ShowLauncher"},
    {key="r", mods="ALT", action="ReloadConfiguration"},
    {key="x", mods="ALT", action=wezterm.action{CloseCurrentPane={confirm=true}}},
    {key="d", mods="ALT", action=wezterm.action.ShowDebugOverlay},
    {key="z", mods="ALT", action=wezterm.action.TogglePaneZoomState},
    {key="+", mods="ALT", action=wezterm.action.IncreaseFontSize},
    {key="-", mods="ALT", action=wezterm.action.DecreaseFontSize},
    {key="PageUp", mods="ALT", action=wezterm.action.ScrollByPage(-1)},
    {key="PageDown", mods="ALT", action=wezterm.action.ScrollByPage(1)},
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
            },
            domain = { DomainName = "local"},
        },
        {
            label = 'Powershell',
            args = {
                'powershell.exe',
                '-nologo'
            },
            domain = { DomainName = "local"},
        },
        {
            label = 'cmd',
            args = {
                'cmd.exe'
            },
            domain = { DomainName = "local"},
        },
    }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then

end
-- and finally, return the configuration to wezterm
return config
