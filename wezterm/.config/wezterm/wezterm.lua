local wezterm = require 'wezterm'
local config = wezterm.action

return {

  font = wezterm.font_with_fallback {
    "JetBrainsMono Nerd Font",
    "Noto Sans Arabic",
  },

  font_size = 12.0,
  color_scheme = "Bamboo",

  -- arabic
  bidi_enabled = true,
  bidi_direction = "LeftToRight",

  -- more history
  scrollback_lines = 10000,

  -- window managing
  -- window_background_opacity = 0.80,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  enable_tab_bar = false,
  window_close_confirmation = 'NeverPrompt',

  -- Key bindings
  keys = {
    {
      key = 'F12',
      mods = 'CTRL|SHIFT',
      action = config.IncreaseFontSize,
    },
    {
      key = 'F11',
      mods = 'CTRL|SHIFT',
      action = config.DecreaseFontSize,
    },
    {
      key = 'F10',
      mods = 'CTRL|SHIFT',
      action = config.ResetFontSize,

    },
    {
      key = 'K',
      mods = 'CTRL|SHIFT',
      action = config.ScrollByLine(-1),

    },
    {
      key = 'J',
      mods = 'CTRL|SHIFT',
      action = config.ScrollByLine(1),

    },
    {
      key = 'U',
      mods = 'CTRL|SHIFT',
      action = config.ScrollByPage(-0.5),

    },
    {
      key = 'D',
      mods = 'CTRL|SHIFT',
      action = config.ScrollByPage(0.5),
    },
    {
      key = 'Y',
      mods = 'CTRL|SHIFT',
      action = config.CopyTo 'ClipboardAndPrimarySelection',
    },
    {
      key = 'P',
      mods = 'CTRL|SHIFT',
      action = config.PasteFrom 'Clipboard',
    },
  }
}
