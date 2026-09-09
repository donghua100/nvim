local function java_root(bufnr)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	if filename == "" then
		return vim.uv.cwd()
	end

	filename = vim.fn.fnamemodify(filename, ":p")
	return vim.fs.root(filename, {
		"gradlew",
		"mvnw",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
		"settings.gradle.kts",
		".git",
	}) or vim.fs.dirname(filename)
end

local function java_workspace(root_dir)
	-- A separate workspace prevents JDTLS indexes and project metadata from leaking
	-- between unrelated Maven/Gradle projects.
	local project_name = vim.fn.fnamemodify(root_dir, ":t")
	local project_id = project_name .. "-" .. vim.fn.sha256(root_dir):sub(1, 10)
	return vim.fs.joinpath(vim.fn.stdpath("data"), "jdtls-workspaces", project_id)
end

local function run_project_task(task)
	local root_dir = java_root(0)
	if not root_dir then
		vim.notify("Java project root not found", vim.log.levels.WARN)
		return
	end

	local is_maven = vim.uv.fs_stat(vim.fs.joinpath(root_dir, "pom.xml")) ~= nil
	local executable = is_maven and (vim.uv.fs_stat(vim.fs.joinpath(root_dir, "mvnw")) and "./mvnw" or "mvn")
		or (vim.uv.fs_stat(vim.fs.joinpath(root_dir, "gradlew")) and "./gradlew" or "gradle")
	local command = is_maven and (task == "test" and "test" or "package") or (task == "test" and "test" or "build")

	vim.cmd("botright 15split")
	vim.cmd("terminal cd " .. vim.fn.shellescape(root_dir) .. " && " .. executable .. " " .. command)
	vim.cmd("startinsert")
end

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
			local registry_ok, registry = pcall(require, "mason-registry")
			local package_ok, jdtls_package = false, nil
			if registry_ok then
				package_ok, jdtls_package = pcall(registry.get_package, "jdtls")
			end

			if not package_ok or not jdtls_package or not jdtls_package:is_installed() then
				vim.notify("JDTLS is not installed yet. Run :MasonInstall jdtls and reopen this Java file.", vim.log.levels.WARN)
				return
			end

			local jdtls_cmd = vim.fs.joinpath(jdtls_package:get_install_path(), "bin", "jdtls")
			jdtls.extendedClientCapabilities = vim.tbl_deep_extend(
				"force",
				jdtls.extendedClientCapabilities or {},
				{ classFileContentsSupport = true, resolveAdditionalTextEditsSupport = true }
			)
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local root_dir = java_root(0)

			jdtls.start_or_attach({
				cmd = { jdtls_cmd, "-data", java_workspace(root_dir) },
				root_dir = root_dir,
				capabilities = capabilities,
				settings = {
					java = {
						eclipse = { downloadSources = true },
						maven = { downloadSources = true },
						implementationsCodeLens = { enabled = true },
						referencesCodeLens = { enabled = true },
						format = { enabled = true },
					},
				},
				on_attach = function(_, bufnr)
					local opts = { buffer = bufnr, silent = true }
					vim.keymap.set("n", "<leader>co", jdtls.organize_imports, vim.tbl_extend("force", opts, { desc = "Organize imports" }))
					vim.keymap.set("n", "<leader>cv", jdtls.extract_variable, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
					vim.keymap.set("v", "<leader>cv", function()
						jdtls.extract_variable(true)
					end, vim.tbl_extend("force", opts, { desc = "Extract variable" }))
					vim.keymap.set("v", "<leader>cm", function()
						jdtls.extract_method(true)
					end, vim.tbl_extend("force", opts, { desc = "Extract method" }))
				end,
			})

			vim.api.nvim_create_user_command("JavaBuild", function()
				run_project_task("build")
			end, { desc = "Build current Maven or Gradle project" })
			vim.api.nvim_create_user_command("JavaTest", function()
				run_project_task("test")
			end, { desc = "Test current Maven or Gradle project" })
		end,
	},
}
