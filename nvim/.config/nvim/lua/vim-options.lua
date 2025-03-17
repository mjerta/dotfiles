vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.wo.number = true
vim.wo.cursorline = true
vim.wo.relativenumber = true
vim.o.scrolloff = 8
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "j", "jzz", { noremap = true, silent = true })
vim.keymap.set("n", "k", "kzz", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ss", ":mksession! ~/.config/nvim/sessions/main-session.vim<CR>", { silent = false })
vim.keymap.set("n", "<leader>sr", ":source ~/.config/nvim/sessions/main-session.vim<CR>", { silent = false })
vim.keymap.set("n", "<leader>i", "^i", { noremap = true })
-- this is used for java maven applications
vim.keymap.set('n', '<leader>m', ':botright 10split | terminal mvn package && java -jar $(ls target/*.jar | head -n 1)<CR>:startinsert<CR>', { noremap = true, silent = true })

-- this is used for live server for simple websites(html, js, css)
vim.keymap.set('n', '<leader>ls', ':botright 10split | terminal live-server --port=3000<CR>:startinsert<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>lk', ':botright 10split | terminal pkill -f live-server<CR>:startinsert<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<C-f>', '<cmd>silent !kitty $HOME/my-setup-scripts/scripts/tmux-sessionizer.sh<CR>')



local term_open = false

vim.keymap.set('n', '<M-/>', '', {
  noremap = true,
  silent = true,
  callback = function()
    if term_open then
      vim.cmd('quit')
      term_open = false
    else
      vim.cmd('botright 10split | terminal')
      term_open = true
    end
  end
})
