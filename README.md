# .dotfiles

Minimal dotfiles for a keyboard-driven workflow.

## Install

```bash
git clone git@github.com:mbrotos/.dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

## What's Included

| Tool | Config |
|------|--------|
| tmux | Vim-style navigation, `Ctrl+a` prefix, sane defaults |
| ghostty | Clickable URLs with Cmd+click |

## Tmux Cheatsheet

| Key | Action |
|-----|--------|
| `Ctrl+a` | Prefix (instead of `Ctrl+b`) |
| `prefix + \|` | Split vertical |
| `prefix + -` | Split horizontal |
| `prefix + hjkl` | Navigate panes |
| `prefix + r` | Reload config |

## Adding New Configs

1. Create a directory: `mkdir ~/.dotfiles/toolname`
2. Add your config file
3. Update `install.sh` with the new symlink
4. Run `./install.sh`
