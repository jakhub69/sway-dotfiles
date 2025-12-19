-- Options
vim.g.mapleader = " "
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"
vim.opt.path = vim.opt.path + "**"
vim.opt.termguicolors = true

-- LSP Config
vim.lsp.config("rust-analyzer", {
  cmd = {"rust-analyzer"},
  filetypes = {"rust"},
  root_markers = {"Cargo.toml", ".git"},
})
vim.lsp.enable("rust-analyzer")

-- Lazy.nvim Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins Setup
require("lazy").setup({
    spec = { 
        -- Colorscheme
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            config = function()
                vim.cmd.colorscheme "catppuccin-frappe"
            end
        },

        -- Telescope
        {
            "nvim-telescope/telescope.nvim", 
            tag = "0.1.8",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons"
            }
        },

        -- 1. Statusline (Lualine)
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            config = function()
                require("lualine").setup({
                    options = { theme = "catppuccin" }
                })
            end
        },

        -- 2. Better Syntax Highlighting (Treesitter)
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                require("nvim-treesitter").setup({
                    -- W nowej wersji używamy bezpośrednio setup na nvim-treesitter
                    ensure_installed = { "rust", "lua", "vim", "vimdoc", "bash", "markdown" },
                    highlight = { enable = true },
                })
            end
        },
        -- 3. Git Signs
        {
            "lewis6991/gitsigns.nvim",
            config = function()
                require("gitsigns").setup()
            end
        },
-- Discord RPC
        {
            "andweeb/presence.nvim",
            lazy = false, -- Wymuszamy ładowanie od razu
            config = function()
                require("presence").setup({
                    auto_update         = true,
                    neovim_image_text   = "The One True Editor",
                    main_image          = "neovim",
                    editing_text        = "Editing %s",
                    workspace_text      = "Working on %s",
                    show_time           = true,
                })
            end
        },
    },
    checker = { enabled = true },
})

-- Keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Telescope LSP references" })
vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Telescope LSP implementations" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP definition" })
