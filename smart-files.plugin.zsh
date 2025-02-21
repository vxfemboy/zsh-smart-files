# smart-files.plugin.zsh

# Get the absolute path of the plugin directory
SMART_FILES_DIR="$(dirname $(readlink -f ${(%):-%x}))"

# Load core functionality
source "${SMART_FILES_DIR}/lib/core.zsh"

# Function to setup highlighter after zsh-syntax-highlighting loads
_smart_files_setup_highlighter() {
    # Add our highlighter to the list
    if (( ${ZSH_HIGHLIGHT_HIGHLIGHTERS[(I)smart_files]} == 0 )); then
        ZSH_HIGHLIGHT_HIGHLIGHTERS+=( smart_files )
    fi
}

# Install the highlighter if zsh-syntax-highlighting is present
_smart_files_install_highlighter() {
    local zsh_syntax_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    local highlighter_dir="$zsh_syntax_dir/highlighters/smart_files"

    # Install highlighter if needed
    if [[ ! -f "$highlighter_dir/smart_files-highlighter.zsh" ]]; then
        source "${SMART_FILES_DIR}/bin/install-highlighter.zsh"
    fi
}

# Add a hook to run after plugins load
autoload -Uz add-zsh-hook
add-zsh-hook precmd _smart_files_check_highlighter

_smart_files_check_highlighter() {
    # Only run once
    add-zsh-hook -d precmd _smart_files_check_highlighter

    # If zsh-syntax-highlighting is loaded
    if [[ -n ${ZSH_HIGHLIGHT_VERSION} ]]; then
        _smart_files_install_highlighter
        _smart_files_setup_highlighter
    fi
}
