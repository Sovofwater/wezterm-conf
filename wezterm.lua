local wezterm = require 'wezterm'

-- Create an object to store all configurations
local config = wezterm.config_builder()


-- 强制 WezTerm 每次打开都使用 zsh，并且作为登录 shell (-l) 运行
config.default_prog = { '/bin/zsh', '-l' }
-- 配置字体
config.font = wezterm.font ('Anonymous Pro', { weight = 'Bold'})


config.font_size = 26.0

config.color_scheme = 'Dracula'

config.window_background_opacity = 0.90
-- config.macos_window_background_blur = 20

-- 启动窗口自动占据左半屏
wezterm.on('gui-startup', function(cmd)
  -- 1. 告诉 WezTerm 在启动时生成一个新窗口
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  local gui_window = window:gui_window()

  -- 2. 获取当前屏幕的物理尺寸信息
  local screens = wezterm.gui.screens()
  local screen = screens.active -- 获取当前活动屏幕

  -- 3. 计算左半屏的尺寸
  local width = math.floor(screen.width / 2)
  
  -- 注意：Mac 顶部有菜单栏 (Menu Bar)，底部有程序坞 (Dock)
  -- 所以高度不能占满，减去 100 像素作为安全边距
  local height = screen.height - 100 

  -- 4. 设置窗口位置和大小
  -- x 坐标设为屏幕最左侧 (screen.x)
  -- y 坐标稍微往下偏移 40 像素，避开 Mac 的顶部菜单栏
  gui_window:set_position(screen.x, screen.y + 40)
  gui_window:set_inner_size(width, height)
end)

config.keys = {

  -- 绑定 Command + K 清屏 (清除当前视口和滚动历史)
  {
    key = 'k',
    mods = 'CMD',
    action = wezterm.action.ClearScrollback 'ScrollbackAndViewport',
  },
}




-- Return this object 'config' to WezTerm
return config
