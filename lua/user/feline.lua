local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')
local navic = require("nvim-navic")

local force_inactive = {
  filetypes = {},
  buftypes = {},
  bufnames = {}
}

local winbar_components = {
  active = {{}, {}, {}},
  inactive = {{}, {}, {}},
}

local components = {
  active = {{}, {}},
  inactive = {{}, {}, {}, {}},
}

local catppuccin = {
  bg = '#1e1e2e',
  black = '#1e1e2e',
  yellow = '#f9e2af',
  cyan = '#94e2d5',
  oceanblue = '#89b4fa',
  green = '#a6e3a1',
  orange = '#fab387',
  violet = '#cba6f7',
  magenta = '#eba0ac',
  white = '#f5e0dc',
  fg = '#f5e0dc',
  skyblue = '#74c7ec',
  red = '#f38ba8',
}

local vi_mode_colors = {
  NORMAL = 'skyblue',
  OP = 'red',
  INSERT = 'green',
  CONFIRM = 'red',
  VISUAL = 'violet',
  LINES = 'violet',
  BLOCK = 'violet',
  REPLACE = 'violet',
  ['V-REPLACE'] = 'violet',
  ENTER = 'cyan',
  MORE = 'cyan',
  SELECT = 'orange',
  COMMAND = 'red',
  SHELL = 'green',
  TERM = 'green',
  NONE = 'yellow'
}

local vi_mode_text = {
  NORMAL = '<|',
  OP = '<|',
  INSERT = '|>',
  VISUAL = '<>',
  LINES = '<>',
  BLOCK = '<>',
  REPLACE = '<>',
  ['V-REPLACE'] = '<>',
  ENTER = '<>',
  MORE = '<>',
  SELECT = '<>',
  COMMAND = '<|',
  SHELL = '<|',
  TERM = '<|',
  NONE = '<>',
  CONFIRM = '|>'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

force_inactive.filetypes = {
  'NvimTree',
  'dbui',
  'packer',
  'startify',
  'fugitive',
  'fugitiveblame'
}

force_inactive.buftypes = {
  'terminal'
}

-- STATUSLINE
-- LEFT

-- vi-mode
components.active[1][1] = {
  provider = function()
    return vi_mode_utils.get_vim_mode()
  end,
  hl = function()
    local val = {}

    val.bg = vi_mode_utils.get_mode_color()
    val.fg = 'black'
    val.style = 'bold'

    return val
  end,
  right_sep = 'right_filled',
  left_sep = 'block'
}
-- filename
components.active[1][2] = {
  provider = function()
    return vim.fn.expand("%:F")
  end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' ',
  left_sep = ' '
}

-- RIGHT

-- gitBranch
components.active[2][1] = {
  provider = 'git_branch',
  hl = {
    fg = 'yellow',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffAdd
components.active[2][2] = {
  provider = 'git_diff_added',
  hl = {
    fg = 'green',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffModfified
components.active[2][3] = {
  provider = 'git_diff_changed',
  hl = {
    fg = 'orange',
    bg = 'bg',
    style = 'bold'
  }
}
-- diffRemove
components.active[2][4] = {
  provider = 'git_diff_removed',
  hl = {
    fg = 'red',
    bg = 'bg',
    style = 'bold'
  },
}

-- fileIcon
components.active[2][5] = {
  provider = function()
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon == nil then
      icon = ''
    end
    return icon
  end,
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  left_sep =  ' ',
  right_sep = ' '
}
-- fileType
components.active[2][6] = {
  provider = 'file_type',
  hl = function()
    local val = {}
    local filename = vim.fn.expand('%:t')
    local extension = vim.fn.expand('%:e')
    local icon, name  = require'nvim-web-devicons'.get_icon(filename, extension)
    if icon ~= nil then
      val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
    else
      val.fg = 'white'
    end
    val.bg = 'bg'
    val.style = 'bold'
    return val
  end,
  right_sep = ' '
}
-- fileSize
components.active[2][7] = {
  provider = 'file_size',
  enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
  hl = {
    fg = 'skyblue',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- fileFormat
components.active[2][8] = {
  provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- fileEncode
components.active[2][9] = {
  provider = 'file_encoding',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
components.active[2][10] = {
  provider = 'position',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- linePercent
components.active[2][11] = {
  provider = 'line_percentage',
  hl = {
    fg = 'white',
    bg = 'bg',
    style = 'bold'
  },
  right_sep = ' '
}
-- scrollBar
components.active[2][12] = {
  provider = 'scroll_bar',
  hl = {
    fg = 'yellow',
    bg = 'bg',
  },
}

-- WINBAR

-- LEFT

-- nvimGps
winbar_components.active[1][1] = {
  provider = function() return navic.get_location() end,
  enabled = function() return navic.is_available() end,
  hl = {
    fg = 'orange',
    style = 'bold'
  }
}

-- MID

-- RIGHT

-- LspName
winbar_components.active[3][1] = {
  provider = 'lsp_client_names',
  hl = {
    fg = 'yellow',
    style = 'bold'
  },
  right_sep = ' '
}
-- diagnosticErrors
winbar_components.active[3][2] = {
  provider = 'diagnostic_errors',
  enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
  hl = {
    fg = 'red',
    style = 'bold'
  }
}
-- diagnosticWarn
winbar_components.active[3][3] = {
  provider = 'diagnostic_warnings',
  enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
  hl = {
    fg = 'yellow',
    style = 'bold'
  }
}
-- diagnosticHint
winbar_components.active[3][4] = {
  provider = 'diagnostic_hints',
  enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
  hl = {
    fg = 'cyan',
    style = 'bold'
  }
}
-- diagnosticInfo
winbar_components.active[3][5] = {
  provider = 'diagnostic_info',
  enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
  hl = {
    fg = 'skyblue',
    style = 'bold'
  }
}

-- INACTIVE

-- fileType
components.inactive[1][1] = {
  provider = 'file_type',
  hl = {
    fg = 'black',
    bg = 'cyan',
    style = 'bold'
  },
  left_sep = {
    str = ' ',
    hl = {
      fg = 'NONE',
      bg = 'cyan'
    }
  },
  right_sep = {
    {
      str = ' ',
      hl = {
        fg = 'NONE',
        bg = 'cyan'
      }
    },
    ' '
  }
}

require('feline').setup({
  theme = catppuccin,
  default_bg = bg,
  default_fg = fg,
  vi_mode_colors = vi_mode_colors,
  components = components,
  force_inactive = force_inactive,
})

require('feline').winbar.setup({
  components = winbar_components,
  force_inactive = force_inactive,
})
