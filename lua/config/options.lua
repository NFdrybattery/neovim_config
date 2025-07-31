-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- neovide设置
if vim.g.neovide then
  -- 功能设置
  vim.g.neovide_hide_mouse_when_typing = true -- 自动隐藏鼠标
  vim.g.neovide_input_ime = true -- 启用输入法
  vim.g.neovide_vsync = true --启用垂直同步
  vim.g.neovide_gpu = true --启用GPU加速
  vim.g.neovide_multigrid = true --启用多网格渲染
  vim.g.neovide_refresh_rate = 75 --刷新率
  vim.g.neovide_refresh_rate_idle = 5  -- 空闲刷新率
  vim.g.neovide_font_subpixel = true -- 字体渲染
  vim.g.neovide_font_italic = true -- 启用斜体
  vim.g.neovide_detach_on_quit = 'always_quit' -- 退出时分离
  vim.g.neovide_backend = "dx11"
  -- 界面设置
  vim.g.neovide_title_background_color = "#222436" -- 背景颜色
  vim.g.neovide_title_text_color = "#65BCFF" -- 标题文字颜色
  vim.g.neovide_window_blurred = true -- 窗口模糊
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_fullscreen = false -- 全屏
  --动画设置
  vim.g.neovide_cursor_animation_length = 0.2 -- 光标动画长度
  vim.g.neovide_cursor_trail_size = 0.5 -- 光标拖尾长度
  vim.g.neovide_cursor_antialiasing = true -- 光标抗锯齿
  vim.g.neovide_cursor_smooth_blink = true -- 光标平滑闪烁
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_cursor_vfx_opacity = 200.0 -- 粒子透明度
  vim.g.neovide_cursor_vfx_particle_lifetime = 2.0 -- 粒子时长
  vim.g.neovide_scroll_animation_length = 0.2 --滚动动画时长
  vim.g.neovide_scroll_animation_far_lines = 1 -- 远距离滚动行数
  vim.g.neovide_cursor_smooth_blink = true -- 光标闪烁
  --内存设置
  vim.g.neovide_no_idle = true  -- 禁止空闲时占用资源
end
-- 基本设置
local opt = vim.opt
opt.guifont = { "JetBrainsMono NFP", "Maple Mono NF CN", ":h12" }
opt.wrap = false
opt.relativenumber = true
opt.shiftwidth = 4
opt.scrolloff = 4 -- 上下端行数
vim.g.lazyvim_picker = "telescope" --查找插件