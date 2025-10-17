local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- functions
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end
local function round(x, increment)
	if increment then
		return round(x / increment) * increment
	end
	return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end
local function clamp(x, min, max)
	return x < min and min or (x > max and max or x)
end
local function darken(color, darkness)
	local red = tonumber(color:sub(2, 3), 16)
	local green = tonumber(color:sub(4, 5), 16)
	local blue = tonumber(color:sub(6, 7), 16)
	red = math.floor(red * darkness)
	green = math.floor(green * darkness)
	blue = math.floor(blue * darkness)
	return string.format("#%02X%02X%02X", red, green, blue)
end
-- only supports http-proxy
local function get_proxy()
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		local _, ProxyEnable, _ = wezterm.run_child_process({
			"powershell.exe",
			"(Get-ItemProperty -Path 'Registry::HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings').ProxyEnable",
		})
		if ProxyEnable:gsub("%s+", "") == "1" then
			local _, ProxyServer, _ = wezterm.run_child_process({
				"powershell.exe",
				"((Get-ItemProperty -Path 'Registry::HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings').ProxyServer | Select-String -Pattern '([a-zA-Z0-9._-]+\\.?)*:\\d+').Matches[0].Value",
			})
			if ProxyServer ~= "" then
				ProxyServer = "http://" .. ProxyServer:gsub("%c", "")
				return ProxyServer
			end
		end
	elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
		return os.getenv("https_proxy")
	end
	return nil
end

local function get_weather(cityid)
	local proxy = get_proxy()
	local curl = "curl"
	if proxy ~= nil then
		print("proxy settings found")
	end
	local success, stdout, stderr = nil, nil, nil
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		success, stdout, _ = wezterm.run_child_process({ "where", "curl" })
		for line in stdout:gmatch("[^\r\n]+") do
			curl = line:gsub("\\", "\\\\")
			success, stdout, _ = wezterm.run_child_process({ curl, "--version" })
			if stdout:find("libz") then
				break
			end
		end
		if not stdout:find("libz") then
			print("no valid curl found. weather cannot be retrieved.")
			return nil
		end
	end
	if proxy ~= nil then
		success, stdout, stderr = wezterm.run_child_process({
			curl,
			"-sf",
			"--compressed",
			"-x",
			proxy,
			"https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16/current_measurement_"
				.. cityid
				.. ".json",
		})
	else
		success, stdout, stderr = wezterm.run_child_process({
			curl,
			"-sf",
			"--compressed",
			"https://s3.eu-central-1.amazonaws.com/app-prod-static.warnwetter.de/v16/current_measurement_"
				.. cityid
				.. ".json",
		})
	end
	if success and stdout then
		local icons = {
			-- Sonne + Wolken
			"☀️",
			"🌤",
			"🌥",
			"☁",
			-- Nebel
			"",
			"",
			-- Regen
			"🌧",
			"🌧",
			"🌧",
			"🌧",
			"🌧",
			-- Mix
			"🌨",
			"🌨",
			-- Schnee
			"🌨",
			"🌨",
			"🌨",
			"🌨",
			-- Sonne + Regen
			"🌦",
			"🌦",
			-- Sonne + Schnee
			"🌦",
			"🌦",
			"🌦",
			"🌦",
			"🌦",
			"🌦",
			-- Gewitter
			"🌩",
			"🌩",
			"🌩",
			"🌩",
			"🌩",
			-- Wind
			"💨",
		}
		local weather_icon = icons[wezterm.json_parse(stdout).icon]
		local weather_temp = wezterm.json_parse(stdout).temperature / 10
		return weather_icon .. weather_temp .. "°C"
	end
	print(stderr)
	return nil
end
-- This is where you actually apply your config choices

-- colorscheme
config.color_scheme = "Gruvbox Dark (Gogh)"
config.window_background_opacity = 0.97

-- font
config.font = wezterm.font("Hasklug Nerd Font", { weight = "Regular" })
config.font_size = 13.0

-- other
config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }
config.scrollback_lines = 3500
config.adjust_window_size_when_changing_font_size = false
-- config.hide_tab_bar_if_only_one_tab = true

-- statusline
wezterm.time.call_after(1, function()
	wezterm.GLOBAL.weather = get_weather(10224) -- Bremen
end)
wezterm.on("update-right-status", function(window, _)
	-- define elements per cell
	local cells = {}
	if wezterm.GLOBAL.weather then
		table.insert(cells, wezterm.GLOBAL.weather)
	end
	table.insert(cells, "  " .. wezterm.strftime("%H:%M"))
	table.insert(cells, "KW: " .. wezterm.strftime("%V"))
	table.insert(cells, "  " .. wezterm.strftime("%d.%m.%Y"))
	local discharging_icons = { "󰂃", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰁹" }
	local charging_icons = { "󰂃", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋" }
	local charge = ""
	local icon = ""
	for _, b in ipairs(wezterm.battery_info()) do
		local idx = clamp(round(b.state_of_charge * 10), 1, 10)
		charge = string.format("%.0f%%", b.state_of_charge * 100)
		if b.state == "Charging" then
			icon = charging_icons[idx]
		else
			icon = discharging_icons[idx]
		end
		table.insert(cells, icon .. " " .. charge)
	end
	-- print all cells
	local elements = {}
	local fg = "#c0c0c0"
	local bg_start = "#ba4a00"
	local bg = {}
	for i = 0, 10 do
		bg[i] = darken(bg_start, 1 - (i / 10.0))
	end
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	table.insert(elements, { Foreground = { Color = bg[1] } })
	table.insert(elements, { Text = SOLID_LEFT_ARROW })
	local id = 0
	local push = function(text, is_last)
		id = id + 1
		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = bg[id] } })
		table.insert(elements, { Text = "  " .. text .. "  " })
		if not is_last then
			table.insert(elements, { Foreground = { Color = bg[id + 1] } })
			table.insert(elements, { Text = SOLID_LEFT_ARROW })
		end
	end
	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0)
	end
	window:set_right_status(wezterm.format(elements))
end)

local SUP_IDX = {
	"¹",
	"²",
	"³",
	"⁴",
	"⁵",
	"⁶",
	"⁷",
	"⁸",
	"⁹",
	"¹⁰",
	"¹¹",
	"¹²",
	"¹³",
	"¹⁴",
	"¹⁵",
	"¹⁶",
	"¹⁷",
	"¹⁸",
	"¹⁹",
	"²⁰",
}
wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
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
	elseif exec_name == "bash" then
		icon = "$"
	elseif exec_name == "fish" then
		icon = "󰈺"
	else
		icon = ""
	end
	title = wezterm.truncate_right(" " .. SUP_IDX[tab.tab_index + 1] .. icon .. "  " .. title .. " ", max_width - 2)
	return {
		{ Text = title },
	}
end)

-- keybindings
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "Tab", mods = "CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "Tab", mods = "CTRL|SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "f", mods = "CTRL", action = wezterm.action({ Search = { Regex = "" } }) },
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{
		key = "v",
		mods = "ALT",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{ key = "LeftArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "RightArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "DownArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "UpArrow", mods = "ALT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "z", mods = "ALT", action = wezterm.action.TogglePaneZoomState },
	{ key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "ALT", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "l", mods = "ALT", action = wezterm.action.ActivateLastTab },
	{ key = "t", mods = "ALT", action = wezterm.action.ShowTabNavigator },
	{ key = "n", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "c", mods = "ALT", action = wezterm.action.ShowLauncher },
	{
		key = "u",
		mods = "ALT",
		action = wezterm.action.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
	},
	{ key = "r", mods = "ALT", action = wezterm.action.ReloadConfiguration },
	{ key = "x", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "o", mods = "ALT", action = wezterm.action.ShowDebugOverlay },
	{ key = "z", mods = "ALT", action = wezterm.action.TogglePaneZoomState },
	{ key = "+", mods = "ALT", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "ALT", action = wezterm.action.DecreaseFontSize },
	{ key = "w", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
	{ key = "s", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
	{ key = "a", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
	{ key = "d", mods = "ALT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
	{ key = "q", mods = "ALT", action = wezterm.action.RotatePanes("CounterClockwise") },
	{ key = "e", mods = "ALT", action = wezterm.action.RotatePanes("Clockwise") },
	{ key = "PageUp", mods = "ALT", action = wezterm.action.ScrollByPage(-1) },
	{ key = "PageDown", mods = "ALT", action = wezterm.action.ScrollByPage(1) },
}
-- os-specific
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- config.default_domain = "WSL:archlinux"
	config.launch_menu = {
		{
			label = "Powershell",
			args = {
				"pwsh.exe",
				"-nologo",
			},
			domain = { DomainName = "local" },
		},
		{
			label = "cmd",
			args = {
				"cmd.exe",
			},
			domain = { DomainName = "local" },
		},
	}
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.launch_menu = {
		{
			label = "Bash",
			args = {
				"bash",
				"-l",
			},
		},
		{
			label = "Fish",
			args = {
				"fish",
				"-l",
			},
		},
	}
end
-- and finally, return the configuration to wezterm
return config
