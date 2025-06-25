# Dependency
- zsh:
  ```bash
  sudo apt-get install zsh
  ```
- oh-my-zsh:
  ```bash
     sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```
- powerlevel10k
  ```bash
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  # Open ~/.zshrc, find the line that sets ZSH_THEME, and change its value to "powerlevel10k/powerlevel10k".
  ```
- node 
# Others

1. zsh
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# nano ~/.zshrc find plugins=(git)
# Append zsh-autosuggestions & zsh-syntax-highlighting to plugins() like this
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

2. fzf
```bash
source <(fzf --zsh)
```
3. tmux
```bash
set -g default-terminal "xterm-256color"

unbind-key C-b

set-option -g prefix C-x
set -g mouse on
set -s set-clipboard on

bind-key C-x send-prefix

bind -r h resize-pane -L 5

bind -r j resize-pane -D 5

bind -r k resize-pane -U 5

bind -r l resize-pane -R 5

bind '%' split-window -h -c '#{pane_current_path}'  # Split panes horizontal
bind '"' split-window -v -c '#{pane_current_path}'  # Split panes vertically
bind c new-window -c '#{pane_current_path}' # Create new window

```
4. ssh
```bash
# ssh-keygen -t ed25519 -C ""
```
5. Alacritty
```bash
# cat  ~/.config/alacritty/alacritty.toml

[font]
# 默认字体设置
normal = { family = "MesloLGS NF", style = "Regular" }

# 粗体字体设置
bold = { family = "MesloLGS NF", style = "Bold" }

# 斜体字体设置
italic = { family = "MesloLGS NF", style = "Italic" }

# 字体大小
size = 20.0

# 偏移设置：控制字体的偏移量
offset = { x = 0, y = 0 }

# 字形偏移设置：控制字形在单元格中的位置
glyph_offset = { x = 0, y = 0 }

```
