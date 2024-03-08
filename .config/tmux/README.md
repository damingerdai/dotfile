# my tmux config

```bash
tmux source-file ~/.config/tmux/tmux.conf
```

以下是使用 Markdown 格式整理的 `tmux` 键绑定说明：

---

# `tmux` 键绑定配置说明

`tmux` 可以通过使用前缀键（prefix key）加命令键的组合进行控制。本配置使用 `C-a` 作为次要前缀，同时保留 `C-b` 作为默认前缀。

## 基本概念

- **`<prefix>`**: 表示需要先按 `Ctrl + a` 或 `Ctrl + b`
- **`<prefix> c`**: 表示先按 `<prefix>`，然后按 `c`
- **`<prefix> C-c`**: 表示先按 `<prefix>`，然后按 `Ctrl + c`

## 键绑定列表

### 通用操作

- **`<prefix> e`**: 打开 `.local` 自定义文件，使用 `$EDITOR` 环境变量定义的编辑器（默认为 `vim`）
- **`<prefix> r`**: 重新加载配置
- **`C-l`**: 清除屏幕和 `tmux` 历史记录

### 会话管理

- **`<prefix> C-c`**: 创建新会话
- **`<prefix> C-f`**: 通过名称切换到另一个会话
- **`<prefix> C-d`**: 将当前的 tmux 会话分离（detach），并返回到原始的终端窗口
- **`<prefix> C-x`**: 关闭当前的窗格（pane）
- **`<prefix> C-b`**: 进入命令模式，然后输入 kill-session 并按下回车键：这个命令可以关闭当前的 tmux 会话

### 窗口和面板操作

- **`<prefix> C-h`** 和 **`<prefix> C-l`**: 导航窗口（默认的 `<prefix> n` 和 `<prefix> p` 被解绑）
- **`<prefix> Tab`**: 切换到最后一个活动窗口
- **`<prefix> -`**: 垂直分割当前面板
- **`<prefix> _`**: 水平分割当前面板
- **`<prefix> h/j/k/l`**: 类似 Vim 的面板导航
- **`<prefix> H/J/K/L`**: 调整面板大小
- **`<prefix> <`** 和 **`<prefix> >`**: 交换面板
- **`<prefix> +`**: 将当前面板最大化到新窗口

### 特殊功能

- **`<prefix> m`**: 开启或关闭鼠标模式
- **`<prefix> U`**: 启动 Urlscan（首选）或 Urlview（如果可用）
- **`<prefix> F`**: 启动 Facebook PathPicker（如果可用）

### 复制和粘贴

- **`<prefix> Enter`**: 进入复制模式
- **`<prefix> b`**: 列出粘贴缓冲区
- **`<prefix> p`**: 从顶部粘贴缓冲区粘贴
- **`<prefix> P`**: 选择粘贴缓冲区进行粘贴

## 复制模式下的键绑定（`copy-mode-vi`）

- **`v`**: 开始选择/视觉模式
- **`C-v`**: 在块状视觉模式和视觉模式之间切换
- **`H`**: 跳到行首
- **`L`**: 跳到行尾
- **`y`**: 将选择复制到顶部粘贴缓冲区
- **`Escape`**: 取消当前操作

---

这份整理旨在提供一个清晰的 `tmux` 键绑定参考，帮助你更高效地使用 `tmux`。
