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
  local name  = vim.fn.input("Note name: ")
  local datetime = os.date('%Y%m%dT%H%M%S')
  local filename = home .. '/' .. name .. '.md'

  -- Attempt to create the file if it does not exist
  local file, err = io.open(filename, "r")
  if file then
    file:close()
    print("Error: Note file already exists: " .. filename)
    return
  end

  file, err = io.open(filename, "w")
  if not file then
    print("Error: Could not create note file at " .. filename .. ": " .. err)
    return
  end

  -- Write metadata
  file:write("---\n")
  file:write("datetime: " .. datetime .. "\n")
  file:write("---\n\n")
  file:close()

  vim.cmd('edit ' .. filename)
end

function M.setup(opts)
  M.opts = vim.tbl_extend("force", M.opts, opts or {})

  vim.api.nvim_create_user_command("ZkHome", M.home, {})
  vim.api.nvim_create_user_command("ZkNewNote", M.new_note, {})
end

return M
