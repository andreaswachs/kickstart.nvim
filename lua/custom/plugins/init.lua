-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
-- vim.opt.guicursor = ""
require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
    }
}

vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, {
    noremap = true,
    silent = true,
    desc = "Code action on visual selection",
})

-- Add key bindings for using tabs
vim.keymap.set('n', '<leader>tn', function() vim.cmd('tabnew') end, { desc = 'Create new tab' })
vim.keymap.set('n', '<leader>tq', function() vim.cmd('tabclose') end, { desc = 'Quit tab' })
vim.keymap.set('n', '<leader>tl', function() vim.cmd('tabnext') end, { desc = 'Move to next tab' })
vim.keymap.set('n', '<leader>th', function() vim.cmd('tabprevious') end, { desc = 'Move to previous tab' })

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Neotree
vim.keymap.set("n", "<space>f", ":Neotree reveal position=current toggle float<CR>", { desc = "Toggle neotree" })

-- Movement in the editor
vim.keymap.set('n', '<C-h>', function() vim.cmd.wincmd("h") end, { desc = 'Terminal left window navigation' })
vim.keymap.set('n', '<C-j>', function() vim.cmd.wincmd("j") end, { desc = 'Terminal down window navigation' })
vim.keymap.set('n', '<C-k>', function() vim.cmd.wincmd("k") end, { desc = 'Terminal up window navigation' })
vim.keymap.set('n', '<C-l>', function() vim.cmd.wincmd("l") end, { desc = 'Terminal right window navigation' })

-- Navigate tabs
vim.keymap.set('n', '<S-h>', function() vim.cmd.tabprevious() end, { desc = 'Move to previous tab'})
vim.keymap.set('n', '<S-l>', function() vim.cmd.tabnext() end, { desc = 'Move to next tab'})
vim.keymap.set('n', '<space>tn', function() vim.cmd.tabnew() end, { desc = 'Create new tab' })
vim.keymap.set('n', '<space>tq', function() vim.cmd.tabclose() end, { desc = 'Close tab'})

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
--:
-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Replace the current word with new stuff
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file execuable"})

--- Gen
vim.keymap.set({ 'v' }, '<leader>g', ':Gen<CR>', { desc = "Open Gen" })



local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimport()
    end,
    group = format_sync_grp,
})


require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "day",    -- The theme is used when the background is set to light
    transparent = true,     -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",                   -- style for sidebars, see below
        floats = "dark",                     -- style for floating windows
    },
    sidebars = { "qf", "help", "terminal" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3,                    -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false,        -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false,                    -- dims inactive windows
    lualine_bold = true,                     -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})


return {
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end
    }, {
        "windwp/nvim-autopairs",
        -- Optional dependency
        dependencies = { 'hrsh7th/nvim-cmp' },
        config = function()
            require("nvim-autopairs").setup {}
            -- If you want to automatically add `(` after selecting a function or method
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end,
    },
    {
        "https://github.com/apple/pkl-neovim",
        lazy = true,
        event = "BufReadPre *.pkl",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        build = function()
            vim.cmd("TSInstall! pkl")
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts) require 'lsp_signature'.setup(opts) end
    },
    {
        "ray-x/go.nvim",
        dependencies = {  -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("go").setup()
        end,
        event = {"CmdlineEnter"},
        ft = {"go", 'gomod'},
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
        's1n7ax/nvim-window-picker',
        name = 'window-picker',
        event = 'VeryLazy',
        version = '2.*',
        config = function()
            require'window-picker'.setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = true, -- show icons in the signs column
            sign_priority = 8, -- sign priority
            -- keywords recognized as todo comments
            keywords = {
                FIX = {
                    icon = " ", -- icon used for the sign, and in search results
                    color = "error", -- can be a hex color, or a named color (see below)
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                    -- signs = false, -- configure signs for some keywords individually
                },
                TODO = { icon = " ", color = "info" },
                HACK = { icon = " ", color = "warning" },
                WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
                TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
            gui_style = {
                fg = "NONE", -- The gui style to use for the fg highlight group.
                bg = "BOLD", -- The gui style to use for the bg highlight group.
            },
            merge_keywords = true, -- when true, custom keywords will be merged with the defaults
            -- highlighting of the line containing the todo comment
            -- * before: highlights before the keyword (typically comment characters)
            -- * keyword: highlights of the keyword
            -- * after: highlights after the keyword (todo text)
            highlight = {
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
                before = "", -- "fg" or "bg" or empty
                keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 400, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
            },
            -- list of named colors where we try to extract the guifg from the
            -- list of highlight groups or use the hex color if hl not found as a fallback
            colors = {
                error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
                warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
                info = { "DiagnosticInfo", "#2563EB" },
                hint = { "DiagnosticHint", "#10B981" },
                default = { "Identifier", "#7C3AED" },
                test = { "Identifier", "#FF00FF" }
            },
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                -- regex that will be used to match keywords.
                -- don't replace the (KEYWORDS) placeholder
                pattern = [[\b(KEYWORDS):]], -- ripgrep regex
                -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
            },
        }
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require('copilot').setup({
                panel = {
                    enabled = true,
                    auto_refresh = true,
                    keymap = {
                        jump_prev = "<C-j>",
                        jump_next = "<C-k>",
                        accept = "<C-l>",
                        refresh = "gr",
                        open = "<M-CR>"
                    },
                    layout = {
                        position = "right", -- | top | left | right | horizontal | vertical
                        ratio = 0.4
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    hide_during_completion = true,
                    debounce = 75,
                    trigger_on_accept = false,
                    keymap = {

                        accept = "<C-l>",
                        accept_word = false,
                        accept_line = false,
                        next = "<M-]>",
                        prev = "<M-[>",
                        dismiss = "<C-k>",

                    },
                },
                filetypes = {
                    yaml = true,
                    markdown = false,
                    help = false,
                    gitcommit = false,
                    gitrebase = false,
                    hgcommit = false,
                    svn = false,
                    cvs = false,
                    ["."] = false,
                    go = true,
                    js = true,
                    ts = true,
                },
                auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
                logger = {
                    file = vim.fn.stdpath("log") .. "/copilot-lua.log",
                    file_log_level = vim.log.levels.OFF,
                    print_log_level = vim.log.levels.WARN,
                    trace_lsp = "off", -- "off" | "messages" | "verbose"
                    trace_lsp_progress = false,
                    log_lsp_messages = false,
                },
                copilot_node_command = 'node',    -- Node.js version must be > 20
                workspace_folders = {},
                copilot_model = "gpt-4o-copilot", -- Current LSP default is gpt-35-turbo, supports gpt-4o-copilot
                root_dir = function()
                    return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
                end,
                should_attach = function(_, _)
                    if not vim.bo.buflisted then
                        return false
                    end

                    if vim.bo.buftype ~= "" then
                        return false
                    end

                    return true
                end,
                server = {
                    type = "nodejs", -- "nodejs" | "binary"
                    custom_server_filepath = nil,
                },
                server_opts_overrides = {},
            })
        end,
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            provider = "copilot",
            providers = {
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-3-5-sonnet-20241022",
                    temperature = 0,
                    max_tokens = 4096,
                },
                copilot = {
                    model = "claude-3.7-sonnet",
                    endpoint = "https://api.githubcopilot.com",
                    allow_insecure = false,
                    timeout = 10 * 60 * 1000,
                    temperature = 0,
                    max_completion_tokens = 1000000,
                    reasoning_effort = "high",
                },
            }
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick",         -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua",              -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua",        -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
        config = function()
            require('avante').setup({
                provider = "copilot", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
                -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
                -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
                -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
                auto_suggestions_provider = "claude",
                cursor_applying_provider = nil, -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase

                ---Specify the special dual_boost mode
                ---1. enabled: Whether to enable dual_boost mode. Default to false.
                ---2. first_provider: The first provider to generate response. Default to "openai".
                ---3. second_provider: The second provider to generate response. Default to "claude".
                ---4. prompt: The prompt to generate response based on the two reference outputs.
                ---5. timeout: Timeout in milliseconds. Default to 60000.
                ---How it works:
                --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
                ---Note: This is an experimental feature and may not work as expected.
                dual_boost = {
                    enabled = false,
                    first_provider = "openai",
                    second_provider = "claude",
                    prompt =
                        "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
                    timeout = 60000, -- Timeout in milliseconds
                },
                behaviour = {
                    auto_suggestions = false, -- Experimental stage
                    auto_set_highlight_group = true,
                    auto_set_keymaps = true,
                    auto_apply_diff_after_generation = false,
                    support_paste_from_clipboard = false,
                    minimize_diff = true,                        -- Whether to remove unchanged lines when applying a code block
                    enable_token_counting = true,                -- Whether to enable token counting. Default to true.
                    enable_cursor_planning_mode = false,         -- Whether to enable Cursor Planning Mode. Default to false.
                    enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
                },
                mappings = {
                    --- @class AvanteConflictMappings
                    diff = {
                        ours = "co",
                        theirs = "ct",
                        all_theirs = "ca",
                        both = "cb",
                        cursor = "cc",
                        next = "]x",
                        prev = "[x",
                    },
                    suggestion = {
                        accept = "<C-l>",
                        next = "<M-l>",
                        prev = "<M-k>",
                        dismiss = "<C-h>",
                    },
                    jump = {
                        next = "]]",
                        prev = "[[",
                    },
                    submit = {
                        normal = "<CR>",
                        insert = "<C-s>",
                    },
                    cancel = {
                        normal = { "<C-c>", "<Esc>", "q" },
                        insert = { "<C-c>" },
                    },
                    sidebar = {
                        apply_all = "A",
                        apply_cursor = "a",
                        retry_user_request = "r",
                        edit_user_request = "e",
                        switch_windows = "<Tab>",
                        reverse_switch_windows = "<S-Tab>",
                        remove_file = "d",
                        add_file = "@",
                        close = { "<Esc>", "q" },
                        close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
                    },
                },
                hints = { enabled = true },
                windows = {
                    ---@type "right" | "left" | "top" | "bottom"
                    position = "right",   -- the position of the sidebar
                    wrap = true,          -- similar to vim.o.wrap
                    width = 50,           -- default % based on available width
                    sidebar_header = {
                        enabled = true,   -- true, false to enable/disable the header
                        align = "center", -- left, center, right for title
                        rounded = true,
                    },
                    input = {
                        prefix = "> ",
                        height = 8, -- Height of the input window in vertical layout
                    },
                    edit = {
                        border = "rounded",
                        start_insert = true, -- Start insert mode when opening the edit window
                    },
                    ask = {
                        floating = false,    -- Open the 'AvanteAsk' prompt in a floating window
                        start_insert = true, -- Start insert mode when opening the ask window
                        border = "rounded",
                        ---@type "ours" | "theirs"
                        focus_on_apply = "ours", -- which diff to focus after applying
                    },
                },
                highlights = {
                    ---@type AvanteConflictHighlights
                    diff = {
                        current = "DiffText",
                        incoming = "DiffAdd",
                    },
                },
                --- @class AvanteConflictUserConfig
                diff = {
                    autojump = true,
                    ---@type string | fun(): any
                    list_opener = "copen",
                    --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
                    --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
                    --- Disable by setting to -1.
                    override_timeoutlen = 500,
                },
                suggestion = {
                    debounce = 600,
                    throttle = 600,
                },
            })
        end,
    },
}

