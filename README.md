# Dotfiles for Peter Bakkum

https://github.com/bakks/bakks

Configured for Dvorak keyboard layout.

Current setup:

* Terminal: kitty
* Shell: zsh
* Window manager: tmux
* Editor: neovim

```
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
```

## Keyboard Cheat Sheet

### kitty

**C-,**
: Open kitty config

**C-⌘-,**
: Reload kitty config

**⌥-⌘-,**
: Show current kitty config

### zsh

**C-t**
: Previous history item

**C-n**
: Next history item

**C-h**
: Cursor left

**C-s**
: Cursor right

### tmux

#### Normal Mode

**C-b**
: Next pane

**C-x**
: Previous pane

**C-g**
: New pane split horizontally

**C-d g**
: New pane split vertically

**C-f**
: Next pane layout

**C-l**
: Kill current pane

**C-d h**
: Resize pane left

**C-d t**
: Resize pane down

**C-d n**
: Resize pane up

**C-d s**
: Resize pane right

**C-d d**
: Swap pane forward

**C-d D**
: Swap pane backward

**C-d r**
: Reload tmux configuration

**C-u**
: Enter copy mode

#### Copy mode

Allows you to manipulate the text of a tmux pane.

**H**
: Cursor left

**T**
: Cursor down

**N**
: Cursor up

**S**
: Cursor right

**t**
: Scroll down

**n**
: Scroll up

**C-t**
: Page down

**C-n**
: Page up

**V / C-v**
: Select text

**y / Y**
: Copy selected text

### neovim

#### Normal mode

**h**
: Cursor left

**t**
: Cursor down

**n**
: Cursor up

**s**
: Cursor left

**C-h**
: Cursor left x12

**C-t**
: Cursor down x8

**C-n**
: Cursor up x8

**C-s**
: Cursor right x12

**j**
: Jump to top of file

**q**
: Jump to bottom of file

**u**
: Un-do

**U**
: Re-do

**.**
: Repeat last action

**dd**
: Delete current line

**i**
: Enter insert mode

**I**
: Enter insert mode at beginning of line

**k**
: Write file

**r**
: Insert a single character ot current location

**C-r**
: Reload file

**C-R**
: Reload vim config

**o**
: Add newline and enter insert mode

**e**
: Delete newline at end of current line

**m**
: Delete selected text and enter insert mode

**C-a**
: Jump to beginning of line

**C-e**
: Jump to end of line

**T**
: Next search result

**N**
: Previous search result

**-**
: Delete trailing whitespace throughout file

**=**
: Grep in local directory

**C-p**
: Open fzf file finder

**C-P**
: Open file tree (nvim-tree.lua)

#### nvim-tree

**o**
: Open selected file

**C-t**
: Open file in new tab

**s**
: Open file with system default program

**R**
: Refresh file tree

**a**
: New file

**r**
: Rename

**y**
: Copy name

**Y**
: Copy path

**gy**
: Copy absolute path
