return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
    cmd = "Neotree",
    init = function() vim.g.neo_tree_remove_legacy_commands = true end,
    opts = function()
        return {
            auto_clean_after_session_restore = true,
            close_if_last_window = true,
            sources = { "filesystem", "buffers", "git_status" },
            source_selector = {
                sources = {
                    { source = "filesystem", display_name = " 󰉓 Files " },
                    { source = "git_status", display_name = " 󰊢 Git " },
                },
            },
            default_component_configs = {
                icon = {
                    folder_open = "",
                    folder_empty = "󰜌",
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                },
                git_status = {
                    symbols = {
                        renamed   = "󰁕",
                        unstaged  = "💣",
                    },
                },
            },
            document_symbols = {
                kinds = {
                    File = { icon = "󰈙", hl = "Tag" },
                    Namespace = { icon = "󰌗", hl = "Include" },
                    Package = { icon = "󰏖", hl = "Label" },
                    Class = { icon = "󰌗", hl = "Include" },
                    Property = { icon = "󰆧", hl = "@property" },
                    Enum = { icon = "󰒻", hl = "@number" },
                    Function = { icon = "󰊕", hl = "Function" },
                    String = { icon = "󰀬", hl = "String" },
                    Number = { icon = "󰎠", hl = "Number" },
                    Array = { icon = "󰅪", hl = "Type" },
                    Object = { icon = "󰅩", hl = "Type" },
                    Key = { icon = "󰌋", hl = "" },
                    Struct = { icon = "󰌗", hl = "Type" },
                    Operator = { icon = "󰆕", hl = "Operator" },
                    TypeParameter = { icon = "󰊄", hl = "Type" },
                    StaticMethod = { icon = '󰠄 ', hl = 'Function' },
                },
            },
            commands = {
                parent_or_close = function(state)
                    local node = state.tree:get_node()
                    if (node.type == "directory" or node:has_children()) and node:is_expanded() then
                        state.commands.toggle_node(state)
                    else
                        require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
                    end
                end,
                child_or_open = function(state)
                    local node = state.tree:get_node()
                    if node.type == "directory" or node:has_children() then
                        if not node:is_expanded() then -- if unexpanded, expand
                            state.commands.toggle_node(state)
                        else -- if expanded and has children, seleect the next child
                            require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
                        end
                    else -- if not a directory just open it
                        state.commands.open(state)
                    end
                end,
                copy_selector = function(state)
                    local node = state.tree:get_node()
                    local filepath = node:get_id()
                    local filename = node.name
                    local modify = vim.fn.fnamemodify

                    local results = {
                        e = { val = modify(filename, ":e"), msg = "Extension only" },
                        f = { val = filename, msg = "Filename" },
                        F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
                        h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
                        p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
                        P = { val = filepath, msg = "Absolute path" },
                    }

                    local messages = {
                        { "\nChoose to copy to clipboard:\n", "Normal" },
                    }
                    for i, result in pairs(results) do
                        if result.val and result.val ~= "" then
                            vim.list_extend(messages, {
                                { ("%s."):format(i), "Identifier" },
                                { (" %s: "):format(result.msg) },
                                { result.val, "String" },
                                { "\n" },
                            })
                        end
                    end
                    vim.api.nvim_echo(messages, false, {})
                    local result = results[vim.fn.getcharstr()]
                    if result and result.val and result.val ~= "" then
                        vim.fn.setreg("+", result.val)
                    end
                end,
                find_in_dir = function(state)
                    local node = state.tree:get_node()
                    local path = node:get_id()
                    require("telescope.builtin").find_files {
                        cwd = node.type == "directory" and path or vim.fn.fnamemodify(path, ":h"),
                    }
                end,
            },
            window = {
                position = "float",
                popup = { -- settings that apply to float position only
                    --size = { height = "20", width = "45" },
                    position = "50%", -- 50% means center it
                },

                width = 30,
                mappings = {
                    ["<space>"] = false, -- disable space until we figure out which-key disabling
                    ["[b"] = "prev_source",
                    ["]b"] = "next_source",
                    Y = "copy_selector",
                    h = "parent_or_close",
                    l = "child_or_open",
                    o = "open",
                },
            },
            filesystem = {
                follow_current_file = true,
                hijack_netrw_behavior = "open_current",
                use_libuv_file_watcher = true,
            },
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function(_) vim.opt_local.signcolumn = "auto" end,
                },
            },
        }
    end,
}

