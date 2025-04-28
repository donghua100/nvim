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
