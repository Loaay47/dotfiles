local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local function attach_keymap(client, bufnr)
  local bufopts = { buffer = bufnr, remap = false }
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>cn", vim.lsp.buf.code_action, bufopts)
end

lspconfig.asm_lsp.setup({
  capabilities = capabilities,
  on_attach = attach_keymap,
})
local orig = vim.lsp.handlers["window/showMessage"]
vim.lsp.handlers["window/showMessage"] = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if client and client.name == "asm_lsp" then
    if result and result.message:match("No .asm%-lsp.toml config file found") then
      return
    end
  end
  return orig(err, result, ctx, config)
end
