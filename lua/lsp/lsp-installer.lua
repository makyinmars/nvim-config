local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = require("lsp.handlers").capabilities,
	}

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("lsp.servers.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	 if server.name == "tailwindcss" then
	 	local tailwindcss_opts = require("lsp.servers.tailwindcss")
	 	opts = vim.tbl_deep_extend("force", tailwindcss_opts, opts)
	 end

  if server.name == "jsonls" then
	 	local jsonls_opts = require("lsp.servers.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	 if server.name == "pyright" then
	 	local pyright_opts = require("lsp.servers.pyright")
	 	opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	 end

	 if server.name == "tsserver" then
	 	local tsserver_opts = require("lsp.servers.tsserver")
	 	opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	 end

	 if server.name == "diagnosticls" then
	 	local diagnosticls_opts = require("lsp.servers.diagnosticls")
	 	opts = vim.tbl_deep_extend("force", diagnosticls_opts, opts)
	 end

	 if server.name == "emmet_ls" then
	 	local emmet_ls_opts = require("lsp.servers.emmet_ls")
	 	opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
	 end

	 if server.name == "graphql" then
	 	local graphql_opts = require("lsp.servers.graphql")
	 	opts = vim.tbl_deep_extend("force", graphql_opts, opts)
	 end

	 if server.name == "html" then
	 	local html_opts = require("lsp.servers.html")
	 	opts = vim.tbl_deep_extend("force", html_opts, opts)
	 end

	 if server.name == "cssls" then
	 	local cssls_opts = require("lsp.servers.cssls")
	 	opts = vim.tbl_deep_extend("force", cssls_opts, opts)
	 end

	 if server.name == "dockerls" then
	 	local dockerls_opts = require("lsp.servers.dockerls")
	 	opts = vim.tbl_deep_extend("force", dockerls_opts, opts)
	 end

	 if server.name == "eslint" then
	 	local eslint_opts = require("lsp.servers.eslint")
	 	opts = vim.tbl_deep_extend("force", eslint_opts, opts)
	 end

	 if server.name == "gopls" then
	 	local gopls_opts = require("lsp.servers.gopls")
	 	opts = vim.tbl_deep_extend("force", gopls_opts, opts)
	 end

	 if server.name == "prismals" then
	 	local prismals_opts = require("lsp.servers.prismals")
	 	opts = vim.tbl_deep_extend("force", prismals_opts, opts)
	 end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
