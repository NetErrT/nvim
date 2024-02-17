local lspconfig = require("lspconfig")

local map = vim.keymap.set
local lsp = vim.lsp
local inspect = vim.inspect
local diagnostic = vim.diagnostic
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

if ok then
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

diagnostic.config({
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "*",
	},
	severity_sort = true,
	float = { border = "rounded" },
})

lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		local buffer = event.buf
		local providers = client.server_capabilities
		local options = { buffer = buffer }

		vim.bo[buffer].omnifunc = nil

		map("n", "<leader>wa", lsp.buf.add_workspace_folder, options)
		map("n", "<leader>wr", lsp.buf.remove_workspace_folder, options)
		map("n",
			"<leader>wl",
			function()
				print(inspect(lsp.buf.list_workspace_folders()))
			end,
			options
		)
		map("n", "d[", diagnostic.goto_prev, options)
		map("n", "d]", diagnostic.goto_next, options)
		map("n", "<leader>d", "<cmd>Telescope diagnostics<cr>", options)

		if providers.documentFormattingProvider then
			map("n",
				"<leader>fm",
				function() lsp.buf.format({ async = true, bufnr = buffer }) end,
				options
			)
		end

		if providers.hoverProvider then
			map("n", "K", lsp.buf.hover, options)
		end

		if providers.implementationProvider then
			map("n", "gi", lsp.buf.implementation, options)
		end

		if providers.referencesProvider then
			map("n", "gr", lsp.buf.references, options)
		end

		if providers.renameProvider then
			map("n", "rn", lsp.buf.rename, options)
		end

		if providers.typeDefinitionProvider then
			map("n", "<leader>td", lsp.buf.type_definition, options)
		end

		if providers.codeActionProvider then
			map("n", "<leader>ca", lsp.buf.code_action, options)
		end

		if providers.signatureHelpProvider then
			map("n", "<leader>sa", lsp.buf.signature_help, options)
		end

		if providers.definitionProvider then
			map("n", "gd", lsp.buf.definition, options)
		end

		if providers.declarationProvider then
			map("n", "gD", lsp.buf.declaration, options)
		end

		if providers.implementationProvider then
			map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", options)
		end

		if providers.referencesProvider then
			map("n", "gr", "<cmd>Telescope lsp_references<cr>", options)
		end

		if providers.definitionProvider then
			map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", options)
		end
	end
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
})

lspconfig.clangd.setup({
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--clang-tidy",
		"--enable-config",
		"--completion-style=detailed",
		"--fallback-style=Google",
		"--header-insertion-decorators",
		"--header-insertion=iwyu",
	},
})
