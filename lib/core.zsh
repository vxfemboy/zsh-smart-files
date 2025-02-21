# lib/core.zsh

# Function to handle smart file operations
function _smart_file_op() {
    local cmd="$1"
    shift
    local args=("$@")

    # Get the target (last argument)
    local target="${args[-1]}"

    # Remove the target from args array
    unset "args[-1]"

    # Get absolute path of target
    local target_path
    if [[ "$target" = /* ]]; then
        target_path="$target"
    else
        target_path="$PWD/$target"
    fi

    # Check if target ends with a slash - indicating directory operation
    if [[ "$target" =~ /$ ]]; then
        # Directory operation case
        if [[ ! -d "$target_path" ]]; then
            mkdir -p "$target_path"
        fi
    else
        # Regular operation case - only create parent directory if needed
        local parent_dir=$(dirname "$target_path")
        if [[ ! -d "$parent_dir" ]]; then
            mkdir -p "$parent_dir"
        fi
    fi

    # Execute the command with -i flag
    command $cmd -i "$@"
}

# Create wrapper functions for each command
function smart_mv() {
    _smart_file_op mv "$@"
}

function smart_cp() {
    _smart_file_op cp "$@"
}

# Create aliases
alias mv='smart_mv'
alias cp='smart_cp'

# Add completion support
compdef smart_mv=mv
compdef smart_cp=cp
