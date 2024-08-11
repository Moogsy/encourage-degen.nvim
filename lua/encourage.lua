local M = {}

local default_encouragements = {
    "Such a naughty pet, doing exactly what I want 😏🐾",
    "Mmm, you're so obedient, just like a good pet should be 🍑🐶",
    "You're making me so proud, keep being my dirty little pet 🖤🐾",
    "Good pet, you know exactly how to please your master 🥵🐾",
    "Look at you, being such a perfect plaything for me 😈🐕",
    "Such a good pet, taking it all like a champ 💦🐾",
    "You're so eager to please, it's driving me wild 😍🐾",
    "You're my favorite, always ready for more fun 🔥🐶",
    "Mmm, keep going, you're making me so proud 😏🐕",
    "Such a naughty pet, you love being used like this 😈🐾",
    "You're so eager, it’s impossible to resist you 🖤🐕",
    "I love seeing you get so into it, my little plaything 😈🐶",
    "You bring out the best in me, my eager pet 😏🐾",
    "Keep it up, you're making me so proud, my dirty pet 🥵🐕",
    "You're the best at what you do, always leaving me wanting more 😈🐾",
    "You're nothing but my toy, here to satisfy me 😈🐾",
    "I love breaking you down, my little pet 😏🐕",
    "Good pet, you know your place beneath me 🖤🐾",
    "You're so filthy, just how I like it 😈💦",
    "I own you, my dirty little pet, and you love it 🖤🐕",
    "Keep begging, pet, you know how much I enjoy it 😈🐶",
    "You're my perfect little pervert, always ready to obey 😏🔥",
    "I love how you surrender completely to me 🖤🐕",
    "Good pet, you exist to please me and you do it so well 😈🐾",
    "You're my naughty little secret, always ready for more 😈🐶"
}

local function show_floating_message(message)
  local width = #message
  local height = 1
  local buf = vim.api.nvim_create_buf(false, true)
  local win_height = vim.api.nvim_get_option("lines")
  local win_width = vim.api.nvim_get_option("columns")

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = win_height - height - 4,
    col = win_width - width - 2,
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, false, opts)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {" " .. message .. " "})

  -- Use FloatBorder for the border color
  vim.api.nvim_win_set_option(win, "winhl", "Normal:NormalFloat,FloatBorder:FloatBorder")

  -- Set a timer to close the window after 5 seconds
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, 5000)
end

local function custom_write_message(encouragements)
  -- Choose a random message
  local message = encouragements[math.random(#encouragements)]
  -- Display the custom message in a floating window
  show_floating_message(message)
end

function M.setup(opts)
  opts = opts or {}
  local encouragements = opts.messages or default_encouragements
  local plugin = vim.api.nvim_create_augroup("CustomWriteMessage", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group=plugin,
    callback=function()
      custom_write_message(encouragements)
    end
  })
end

return M
