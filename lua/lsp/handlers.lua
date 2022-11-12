local M = {}

-- TODO: backfill this to template
M.setup = function()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		-- disable virtual text
		virtual_text = false,
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function lsp_highlight_document(client)
	-- Set autocommands conditional on server_capabilities
	if client.server_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		"gl",
		'<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<CR>',
		opts
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format(nil, 2000)' ]])
end

M.on_attach = function(client, bufnr)
	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end
	lsp_keymaps(bufnr)
	lsp_highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local sumneko_lua = require("lsp.servers.sumneko_lua")
local tailwind_css = require("lsp.servers.tailwindcss")
local jsonls = require("lsp.servers.jsonls")
local pyright = require("lsp.servers.pyright")
local tsserver = require("lsp.servers.tsserver")
local diagnosticls = require("lsp.servers.diagnosticls")
local emmet_ls = require("lsp.servers.emmet_ls")
local graphql = require("lsp.servers.graphql")
local html = require("lsp.servers.html")
local cssls = require("lsp.servers.cssls")
local dockerls = require("lsp.servers.dockerls")
local eslint = require("lsp.servers.eslint")
local gopls = require("lsp.servers.gopls")
local prismals = require("lsp.servers.prismals")

require("lspconfig")["sumneko_lua"].setup({
	settings = sumneko_lua.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["tailwind_css"].setup({
	settings = tailwind_css.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["jsonls"].setup({
	settings = jsonls.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["pyright"].setup({
	settings = pyright.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["tsserver"].setup({
	settings = tsserver.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["diagnosticls"].setup({
	settings = diagnosticls.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["emmet_ls"].setup({
	settings = emmet_ls.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["graphql"].setup({
	settings = graphql.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["html"].setup({
	settings = html.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["dockerls"].setup({
	settings = dockerls.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["eslint"].setup({
	settings = eslint.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["gopls"].setup({
	settings = gopls.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["prismals"].setup({
	settings = prismals.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})

require("lspconfig")["cssls"].setup({
	settings = cssls.settings,
	on_attach = M.on_attach,
	capabilities = capabilities,
})


local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
	return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
