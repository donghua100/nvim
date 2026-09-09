# Neovim Configuration Rules

## Architecture

config/
    editor core only

plugins/
    feature modules only

## Plugin Categories

ui/
navigation/
editor/
coding/
git/
ai/

## Principles

- one file per plugin
- no giant plugin.lua
- use lazy.nvim
- use Neovim 0.12 APIs
- use vim.lsp.config()
- use blink.cmp
- use conform.nvim
- use nvim-lint

## Avoid

- deprecated lspconfig setup()
- monolithic plugin files
- duplicated keymaps

## 依赖
- sudo pacman -S tree-sitter-cli
- a C compiler in your path
- nodejs
- fzf

## 坑点
- treesitter nil
render-markdown 导致
