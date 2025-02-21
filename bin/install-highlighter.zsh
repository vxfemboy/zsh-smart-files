# bin/install-highlighter.zsh

install_smart_files_highlighter() {
    # Find the real path of this script first
    local script_path="$(readlink -f ${(%):-%x})"
    local plugin_dir="$(dirname $(dirname $script_path))"
    local zsh_syntax_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    local highlighter_dir="$zsh_syntax_dir/highlighters/smart_files"
    local source_dir="$plugin_dir/lib/highlighter"

    # Check if zsh-syntax-highlighting is installed
    if [[ ! -d "$zsh_syntax_dir" ]]; then
        echo "zsh-syntax-highlighting not found"
        return 1
    fi

    # Check if highlighter is already installed
    if [[ -f "$highlighter_dir/smart_files-highlighter.zsh" ]]; then
        echo "smart-files highlighter already installed"
        return 0
    fi

    # Debug info
    echo "Installing highlighter..."
    echo "Script path: $script_path"
    echo "Plugin dir: $plugin_dir"
    echo "Source dir: $source_dir"
    echo "Target dir: $highlighter_dir"

    # Check if source files exist
    if [[ ! -f "$source_dir/smart_files-highlighter.zsh" ]]; then
        echo "Error: Source highlighter file not found at $source_dir/smart_files-highlighter.zsh"
        return 1
    fi

    if [[ ! -f "$source_dir/test-data/smart-files.zsh" ]]; then
        echo "Error: Source test file not found at $source_dir/test-data/smart-files.zsh"
        return 1
    fi

    # Create directories
    mkdir -p "$highlighter_dir/test-data"

    # Copy highlighter files
    cp "$source_dir/smart_files-highlighter.zsh" "$highlighter_dir/" && \
    cp "$source_dir/test-data/smart-files.zsh" "$highlighter_dir/test-data/" && \
    echo "smart-files highlighter installed successfully" || \
    echo "Failed to install highlighter"
}

install_smart_files_highlighter
