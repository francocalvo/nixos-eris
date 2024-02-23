local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
	debug = true,
	sources = {
		formatting.prettier,

		formatting.stylua,
		formatting.shfmt,
		formatting.google_java_format,
		diagnostics.shellcheck,

		-- Python
		formatting.ruff,
		diagnostics.ruff,
		diagnostics.mypy,
		--[[ diagnostics.pylint, ]]
		--[[ formatting.black, ]]

		--# C++
		diagnostics.cpplint,
		diagnostics.clang_check,
		diagnostics.cppcheck,
		formatting.clang_format,

		--# NIX
		formatting.nixfmt,
		diagnostics.deadnix,

		--# LaTeX
		formatting.latexindent.with({
			filetypes = { "tex", "bib" },
			extra_args = { "-m", "-l=" .. vim.fn.stdpath("config") .. "/lua/user/lsp/settings/latexindent.yaml" },
		}),
		diagnostics.chktex,

		--# Beancount
		formatting.bean_format,

		--# SQL
		formatting.sqlfluff.with({
			extra_args = { "--dialect", "tsql" }, -- change to your dialect
		}),

		--# Markdown
		--[[ diagnostics.markdownlint, ]]
		--[[ formatting.markdownlint, ]]

		--# Terraform
		diagnostics.terraform_validate,
		diagnostics.trivy,
		formatting.terraform_fmt,
	},
})

local unwrap = {
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = { "rust" },
	generator = {
		fn = function(params)
			local diagnostics = {}
			-- sources have access to a params object
			-- containing info about the current file and editor state
			for i, line in ipairs(params.content) do
				local col, end_col = line:find("unwrap()")
				if col and end_col then
					-- null-ls fills in undefined positions
					-- and converts source diagnostics into the required format
					table.insert(diagnostics, {
						row = i,
						col = col,
						end_col = end_col,
						source = "unwrap",
						message = "hey " .. os.getenv("USER") .. ", don't forget to handle this",
						severity = 2,
					})
				end
			end
			return diagnostics
		end,
	},
}

null_ls.register(unwrap)
