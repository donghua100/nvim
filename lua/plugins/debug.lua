return {
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
    config = function()
        require("mason-nvim-dap").setup()
        local dap = require 'dap'
        local dapui = require 'dapui'
        -- dap.set_log_level('DEBUG')
        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'Debug: Set Breakpoint' })

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup()

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        dap.adapters.lldb = {
            type = 'executable',
            command = '/opt/homebrew/opt/llvm/bin/lldb-dap', -- Adjust to the path to lldb-vscode on your system
            name = "lldb-dap"
        }

        -- Configure the debug configurations for C and C++
        dap.configurations.cpp = {
            {
                type = "lldb",
                request = "launch",
                name = "Launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
            }
        }

        -- Use the same configuration for C
        dap.configurations.c = dap.configurations.cpp


        -- python
        dap.adapters.python = function(cb, config)
            if config.request == 'attach' then
                ---@diagnostic disable-next-line: undefined-field
                local port = (config.connect or config).port
                ---@diagnostic disable-next-line: undefined-field
                local host = (config.connect or config).host or '127.0.0.1'
                cb({
                type = 'server',
                port = assert(port, '`connect.port` is required for a python `attach` configuration'),
                host = host,
                options = {
                    source_filetype = 'python',
                },
                })
            else
                cb({
                type = 'executable',
                ---@diagnostic disable-next-line: undefined-field
                command = config.pythonPath,
                args = { '-m', 'debugpy.adapter' },
                options = {
                    source_filetype = 'python',
                },
                })
            end
        end


        dap.configurations.python = {
            {
                -- The first three options are required by nvim-dap
                type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = 'launch';
                name = "Launch file";
                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
                program = "${file}"; -- This configuration will launch the current file if used.
                pythonPath = function()
                    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                    local conda_prefix = os.getenv('CONDA_PREFIX')
                    if conda_prefix then
                        return conda_prefix .. '/bin/python'
                    else
                        return '/usr/bin/python3'
                    end
                end;
            },
        }
    end
}
