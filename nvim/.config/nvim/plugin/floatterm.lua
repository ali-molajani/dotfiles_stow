-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
-- return {}

-- Function to create a floating window
local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}
local function create_floating_window(opts)
  -- Get the current screen dimensions
  local screen_width = vim.o.columns
  local screen_height = vim.o.lines

  -- Set default width and height to 80% of the screen size
  local width = math.floor(screen_width * 0.8)
  local height = math.floor(screen_height * 0.8)

  -- Override default width and height with options if provided
  if opts then
    if opts.width then
      width = opts.width
    end
    if opts.height then
      height = opts.height
    end
  end

  -- Calculate the starting position to center the window
  local row = math.floor((screen_height - height) / 2)
  local col = math.floor((screen_width - width) / 2)

  -- Define the window options
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }

  -- Create a buffer for the floating window
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end
  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  return { buf = buf, win = win }
end

local toggle_term = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end
vim.api.nvim_create_user_command('Floatterm', toggle_term, {})
