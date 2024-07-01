return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }, 
    cmd = 'Neotree',
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    opts = {
        event_handlers = {
          {
            event = "file_open_requested",
            handler = function()
              -- auto close
              -- vimc.cmd("Neotree close")
              -- OR
              require("neo-tree.command").execute({ action = "close" })
            end
          },
        },

        window = {
            mappings = {
            ['e'] = function() vim.api.nvim_exec('Neotree focus filesystem left', true) end,
            ['b'] = function() vim.api.nvim_exec('Neotree focus buffers left', true) end,
            ['g'] = function() vim.api.nvim_exec('Neotree focus git_status left', true) end,
        },
  },
    },
    init = function()
        vim.g.loaded_netrw       = 1
	    vim.g.loaded_netrwPlugin = 1
        local stats = vim.uv.fs_stat(vim.fn.argv(0))
        if stats and stats.type == "directory" then
            -- require("neo-tree").toggle()
            vim.api.nvim_create_autocmd("VimEnter", {
            callback = function()
                -- 检查打开的路径是否是目录
                local stats = vim.uv.fs_stat(vim.fn.argv(0))
                if stats and stats.type == "directory" then
                    vim.cmd[[Neotree]]

                end
            end,
            once = true
        })
        end
    end,
}
