return {
	{
		"mfussenegger/nvim-jdtls",
		ft = "java",

		dependencies = {
			"mason-org/mason.nvim",
			"saghen/blink.cmp",
		},

		config = function()
			local jdtls = require("jdtls")
			local mason_registry = require("mason-registry")

			----------------------------------------------------------------
			-- Maven
			----------------------------------------------------------------

			local function is_maven_parent(pom_path)
				local file = io.open(pom_path, "r")

				if not file then
					return false
				end

				local content = file:read("*a")

				file:close()

				return content:match("<modules>") ~= nil or content:match("<module>")
			end

			local function find_maven_root()
				local file_path = vim.api.nvim_buf_get_name(0)

				if file_path == "" then
					return nil
				end

				local dir = vim.fs.dirname(file_path)

				while dir and dir ~= "" do
					local pom_path = vim.fs.joinpath(dir, "pom.xml")

					if vim.uv.fs_stat(pom_path) then
						if is_maven_parent(pom_path) then
							return dir
						end
					end

					local parent = vim.fs.dirname(dir)

					if parent == dir then
						break
					end

					dir = parent
				end

				return vim.fs.root(0, {
					"pom.xml",
					"mvnw",
				})
			end

			----------------------------------------------------------------
			-- JDTLS
			----------------------------------------------------------------

			local jdtls_package = mason_registry.get_package("jdtls")

			if not jdtls_package:is_installed() then
				vim.notify("jdtls is not installed", vim.log.levels.ERROR)
				return
			end

			local jdtls_path = jdtls_package:get_install_path()

			local jdtls_cmd = vim.fs.joinpath(jdtls_path, "bin", "jdtls")

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local function start_jdtls()
				if vim.bo.filetype ~= "java" then
					return
				end

				if #vim.lsp.get_clients({
					bufnr = 0,
					name = "jdtls",
				}) > 0 then
					return
				end

				local root_dir = find_maven_root()

				if not root_dir then
					vim.notify("Java project root not found", vim.log.levels.WARN)
					return
				end

				local project_name = vim.fn.fnamemodify(root_dir, ":t")

				local workspace = vim.fs.joinpath(vim.fn.stdpath("data"), "jdtls-workspace", project_name)
				----------------------------------------------------------------
				-- Java Debug Adapter
				----------------------------------------------------------------

				local java_debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path()

				local java_debug_bundle =
					vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)

				----------------------------------------------------------------
				-- JDTLS
				----------------------------------------------------------------
				jdtls.start_or_attach({
					cmd = {
						jdtls_cmd,
						"-data",
						workspace,
					},

					root_dir = root_dir,

					capabilities = capabilities,
					-- java dap
					init_options = {
						bundles = {
							java_debug_bundle,
						},
					},
					{
						dap = {
							hotcodereplace = "auto",
						},
					},
				})
			end

			local jdtls_group = vim.api.nvim_create_augroup("JdtlsAutoStart", {
				clear = true,
			})

			vim.api.nvim_create_autocmd("FileType", {
				group = jdtls_group,
				pattern = "java",
				callback = start_jdtls,
			})

			if vim.bo.filetype == "java" then
				start_jdtls()
			end

			----------------------------------------------------------------
			-- Maven executable
			----------------------------------------------------------------

			local function get_maven_executable(root_dir)
				local mvnw = vim.fs.joinpath(root_dir, "mvnw")

				if vim.uv.fs_stat(mvnw) then
					return "./mvnw"
				end

				return "mvn"
			end

			local function run_maven(goal, height)
				local root_dir = find_maven_root()

				if not root_dir then
					vim.notify("Maven project root not found", vim.log.levels.WARN)
					return
				end

				local executable = get_maven_executable(root_dir)

				vim.cmd("botright " .. height .. "split")

				vim.cmd("terminal cd " .. vim.fn.shellescape(root_dir) .. " && " .. executable .. " " .. goal)

				vim.cmd("startinsert")
			end

			vim.api.nvim_create_user_command("MavenCompile", function()
				run_maven("compile", 15)
			end, {
				desc = "Maven: compile",
			})

			vim.api.nvim_create_user_command("MavenTest", function()
				run_maven("test", 15)
			end, {
				desc = "Maven: test",
			})

			vim.api.nvim_create_user_command("MavenPackage", function()
				run_maven("package", 15)
			end, {
				desc = "Maven: package",
			})

			vim.api.nvim_create_user_command("MavenVerify", function()
				run_maven("verify", 15)
			end, {
				desc = "Maven: verify",
			})

			vim.api.nvim_create_user_command("MavenClean", function()
				run_maven("clean", 15)
			end, {
				desc = "Maven: clean",
			})

			vim.api.nvim_create_user_command("MavenDependencyTree", function()
				run_maven("dependency:tree", 20)
			end, {
				desc = "Maven: dependency tree",
			})
		end,
	},
}
