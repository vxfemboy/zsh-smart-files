# Smart Files Plugin for Zsh

A zsh plugin that enhances command-line operations by providing visual feedback for file paths. It automatically highlights paths in different colors based on their status (existing, new, or permission-denied).

## Features

- Visual path highlighting while typing commands:
  - Blue: Existing files/directories with appropriate permissions
  - Yellow: New/non-existent paths
  - Red: Permission-denied paths
- Works with all commands, not just file operations
- Handles both absolute and relative paths
- Supports tilde (~) expansion
- Special handling for read-only commands (cat, less, head, tail)
- Preserves all original command functionality
- Integrates with zsh-syntax-highlighting

## Installation

### Manual

```bash
git clone https://github.com/vxfemboy/smart-files.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/smart-files
```

### Oh My Zsh

1. Clone the repository:
```bash
git clone https://github.com/vxfemboy/smart-files.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/smart-files
```

2. Add smart-files to your plugin list in ~/.zshrc:
```bash
plugins=(... smart-files)
```

3. Restart your shell or source your ~/.zshrc:
```bash
source ~/.zshrc
```

## Usage

The plugin works automatically with any command. Here are some examples of how the highlighting works:

```bash
# File Operations
mv file.txt new/directory/     # new/directory/ in yellow if it doesn't exist
cp config.yml ~/.config/       # ~/.config/ in blue if it exists
rm -rf /etc/something/        # Path in red if you don't have permissions

# Development
vim new_script.py            # Yellow for new files
gcc source.c -o output      # Highlights both source and output appropriately
python ~/.local/script.py   # Blue for existing files

# Read-only Operations
cat /etc/passwd            # Blue if readable, red if not
less /var/log/syslog      # Red if permission denied
head ~/.bashrc            # Blue for existing readable files
```

### Highlight Colors

- Blue: The path exists and you have appropriate permissions
- Yellow: The path doesn't exist (useful for creating new files/directories)
- Red: The path exists but you don't have proper permissions

### Command Types

The plugin behaves differently based on the type of command:

- File modification commands (mv, cp, mkdir, etc.):
  - Shows yellow for new paths
  - Shows red for insufficient permissions
  - Shows blue for existing paths with proper permissions

- Read-only commands (cat, less, head, tail):
  - Only shows blue or red (no yellow highlighting)
  - Red indicates insufficient read permissions
  - Blue indicates the file exists and is readable

## License

MIT License
