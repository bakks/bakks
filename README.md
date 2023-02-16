# Dotfiles for Peter Bakkum

https://github.com/bakks/bakks

Configured for Dvorak keyboard layout.

Current setup:

- Terminal: kitty
- Shell: zsh
- Window manager: tmux
- Editor: neovim

```
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Brew packages
# node@16 is necessary because Github Copilot vim plugin currently requires 12.x-17.x
brew install node@16 tmux nvim fzf go yarn git gh htop reattach-to-user-namespace entr coreutils wget kitty grc
brew install homebrew/cask-fonts/font-hack-nerd-font
brew install bakks/bakks/poptop

# npm packages
npm install -g typescript typescript-language-server pyright

gh auth login

# Populate the homedir with this repo's contents
cd ~
gh repo clone bakks/bakks
rsync -a bakks/ ./
rm -rf bakks/
```

## To do

- Moving cursor left/right when in the command mode (e.g. activate by renaming `cR`)
- Move to next or previous LSP error
- Add karabiner config info here

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
: Insert a single character at current location

**C-r**
: Reload file

**;**
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

**P**
: Open file tree (nvim-tree.lua)

**zR**
: Unfold all

**[0-9]B**
: Go to numbered tab

**B**
: Next tab

**M**
: Previous tab

**Q**
: Quit file

#### LSP / Autocompletion

**cd**
: Go to definiton

**cD**
: Go to declaration

**ck**
: Show definition in hover window

**ci**
: Go to implementation

**cr**
: Show references

**cR**
: Rename current symbol

**tab**
: Select next autocompletion result

#### nvim-tree

**o**
: Open selected file

**O**
: Open file in new tab

**Tab**
: Preview file

**t / C-t**
: Next file

**C-n**
: Go to parent

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
