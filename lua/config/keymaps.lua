-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 优化删除逻辑
-- 其他删除操作均使用黑洞寄存器（不存入）
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
-- Visual 模式下的删除/替换
vim.keymap.set("x", "x", '"_x')
vim.keymap.set("x", "c", '"_c')
vim.keymap.set("x", "p", '"_dP')
--优化行尾选择
-- 让 v$ 选中到行尾但不含换行符（等效于 vg_）
vim.keymap.set('x', '$', 'g_', { noremap = true, silent = true })
--禁用qq快捷键
-- 禁用 qq 的宏录制功能, 避免误触
vim.keymap.set({'n', 'x'}, 'q', '<Nop>', { noremap = true, silent = true })



