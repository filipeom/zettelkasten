local M = {}

M.opts = {
  home = '~/Notes',
}

function M.home()
  local home = M.opts.home
  vim.cmd('edit ' .. home)
end

function M.new_note()
  local home = M.opts.home
  local suffix = vim.fn.input("Note suffix: ")
  local datetime = os.date('%Y%m%dT%H%M%S')
  local filename = home .. '/' .. datetime .. '-' .. suffix .. '.md'
  vim.cmd('edit ' .. filename)
end

function M.setup(opts)
  M.opts = vim.tbl_extend("force", M.opts, opts or {})

  vim.api.nvim_create_user_command("ZkHome", M.home, {})
  vim.api.nvim_create_user_command("ZkNewNote", M.new_note, {})
end

return M
