local wezterm = require 'wezterm'
local config = {}
local launch_menu = {}

config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 14.0
config.window_close_confirmation = "NeverPrompt"
config.color_scheme = 'Gruvbox dark, hard (base16)'
config.selection_word_boundary = " \t\n{}[]()\"'`,;:@│┃*"
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.use_fancy_tab_bar = false
config.launch_menu = launch_menu
-- config.window_background_image = 'C:/Users/lounes/.config/wezterm/image.png'

--- Setup PowerShell options
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  --- Grab the ver info for later use.
  local success, stdout, stderr = wezterm.run_child_process { 'cmd.exe', 'ver' }
  local major, minor, build, rev = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
  --- Set Pwsh as the default on Windows
  config.default_prog = { 'pwsh.exe', '-NoLogo' }
  table.insert(launch_menu, {
    label = 'Pwsh',
    args = { 'pwsh.exe', '-NoLogo' },
  })
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })
  table.insert(launch_menu, {
    label = 'Pwsh No Profile',
    args = { 'pwsh.exe', '-NoLogo', '-NoProfile' },
  })
  table.insert(launch_menu, {
    label = 'PowerShell No Profile',
    args = { 'powershell.exe', '-NoLogo', '-NoProfile' },
  })
else
  --- Non-Windows Machine
  table.insert(launch_menu, {
    label = 'Pwsh',
    args = { '/usr/local/bin/pwsh', '-NoLogo' },
  })
  table.insert(launch_menu, {
    label = 'Pwsh No Profile',
    args = { '/usr/local/bin/pwsh', '-NoLogo', '-NoProfile' },
  })
end



config.keys = {
  {
    key = 'p', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCommandPalette,},
  { key = 'T', mods = 'CTRL', action = wezterm.action.ShowLauncher },
  { key = 'R', mods = 'SHIFT|CTRL', action = wezterm.action.ReloadConfiguration },
}
return config
