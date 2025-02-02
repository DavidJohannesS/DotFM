require("meow")
--vim.diagnostic.config({
--  virtual_text = false
--})
vim.cmd [[
  au BufNewFile,BufRead *.yaml,*.yml set filetype=yaml.ansible
]]
