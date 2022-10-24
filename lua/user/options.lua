--syntax enable                           " Enables syntax highlighting
--vim.optspell spelllang=en                  " vim.optspell checking
vim.opt.hidden = true                       -- Required to keep multiple buffers open multiple buffers
vim.opt.wrap = true                         -- Display long lines as just one line
vim.opt.encoding = "utf-8"                      -- The encoding displayed
vim.opt.pumheight = 10                        -- Makes pop up menu smaller
vim.opt.fileencoding = "utf-8"                  -- The encoding written to file
vim.opt.ruler = true             			-- Show the cursor position all the time
vim.opt.cmdheight = 2                         -- More space for displaying messages
--vim.opt.iskeyword+=-                      	-- treat dash separated words as a word text object"
vim.opt.mouse = "a"                             -- Enable your mouse
vim.opt.splitbelow = true                          -- Horizontal splits will automatically be below
vim.opt.splitright = true                    -- Vertical splits will automatically be to the right
--vim.opt.t_Co=256                            -- Support 256 colors
vim.opt.conceallevel = 0                      -- So that I can see `` in markdown files
vim.opt.tabstop = 4                           -- Insert 2 spaces for a tab
vim.opt.shiftwidth = 4                        -- Change the number of space characters inserted for indentation
vim.opt.smarttab = true                            -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab = true                     -- Converts tabs to spaces
vim.opt.smartindent = true                    -- Makes indenting smart
vim.opt.autoindent = true                  -- Good auto indent
vim.opt.laststatus= 2                        -- Always display the status line
vim.opt.number = true                         -- Line numbers
vim.opt.cursorline = true                     -- Enable highlighting of the current line
vim.opt.background="dark"                     -- tell vim what the background color looks like
vim.opt.showtabline= 2                       -- Always show tabs
--vim.opt.showmode = true                  -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup = false                     -- This is recommended by coc
vim.opt.writebackup = false               -- This is recommended by coc
vim.opt.updatetime=300                      -- Faster completion
vim.opt.timeoutlen=500                      -- By default timeout length is 1000 ms
--vim.opt.formatoptions-=cro                  -- Stop newline continuation of comments
vim.opt.clipboard="unnamedplus"               -- Copy paste between vim and everything else
--vim.opt.autochdir                         --" Your working directory will always be the same as your working directory
vim.opt.ignorecase = true                     -- Ignore case in search
vim.opt.incsearch = true                   -- Show search results as you type
vim.opt.hlsearch = true                    -- Highlight search results
vim.opt.textwidth = 80                        -- Push cursor to new line after 80 characters
vim.opt.termguicolors = true


vim.api.nvim_create_autocmd("User", {
	pattern = "PackerCompileDone",
	callback = function()
		vim.cmd "CatppuccinCompile"
		vim.defer_fn(function()
			vim.cmd "colorscheme catppuccin"
		end, 0) -- Defered for live reloading
	end
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "plugins.lua", "catppuccin.lua" },
	callback = function()
		vim.cmd "PackerCompile"
	end
})
