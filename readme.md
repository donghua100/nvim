# Neovim 配置设计

## 总体原则

- **模块化**：按功能拆分插件配置，避免所有插件集中在一个文件中。
- **职责单一**：每个目录、每个配置文件尽量只负责一类功能。
- **分层设计**：从 Neovim Core → lazy.nvim → 开发能力 → 编辑能力 → UI，逐层构建。
- **独立于发行版**：不依赖 LazyVim，基于 Neovim 原生能力和 lazy.nvim 自己搭建。
- **可扩展**：后续增加语言、调试器、AI、工具时，只需要增加对应模块。

## 当前配置

```text
lua/
├── config/
│   ├── lazy.lua
│   ├── options.lua
│   ├── keymaps.lua
│   └── autocmds.lua
│
└── plugins/
    ├── ai/          # AI
    ├── editor/      # 编辑体验
    ├── lsp/         # LSP / Mason / 语言配置
    ├── debug/       # DAP
    ├── git/         # Git
    ├── navigation/  # 文件、搜索、诊断导航
    └── ui/          # 界面与显示


五层架构
┌──────────────────────────────────────┐
│              UI / 导航                │
│  which-key / trouble / fzf / notify  │
├──────────────────────────────────────┤
│              编辑能力                 │
│ blink / LuaSnip / Treesitter          │
│ conform / nvim-lint / autopairs       │
├──────────────────────────────────────┤
│              开发能力                 │
│ LSP / DAP / Mason                     │
├──────────────────────────────────────┤
│              插件管理                 │
│              lazy.nvim                │
├──────────────────────────────────────┤
│              Neovim Core              │
│ vim.api / vim.lsp / vim.treesitter    │
│ vim.diagnostic / vim.opt              │
└──────────────────────────────────────┘
```
## 未来思路
- Core 层：保持简单，只负责 Neovim 原生配置。
- Plugin Manager 层：统一由 lazy.nvim 管理插件生命周期。
- 开发能力层：逐步完善 LSP、DAP、Mason，并针对 Java、C/C++、Python、Lua 等语言扩展。
- 编辑能力层：完善补全、代码片段、语法树、格式化、Lint 等基础开发体验。
- UI / Navigation 层：负责界面、美化、搜索、文件管理和诊断导航，不与核心开发功能耦合。
- AI 层：独立管理 Copilot、CodeCompanion 等 AI 工具，避免影响基础编辑和开发环境。
- 核心目标：先搭建稳定的 Neovim Core，再逐层增加能力；插件之间低耦合，功能模块可独立替换。
