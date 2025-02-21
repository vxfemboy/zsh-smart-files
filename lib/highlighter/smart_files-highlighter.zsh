# lib/highlighter/smart_files-highlighter.zsh

: ${ZSH_HIGHLIGHT_STYLES[smart-files:newpath]:=fg=yellow}
: ${ZSH_HIGHLIGHT_STYLES[smart-files:existingpath]:=fg=blue}
: ${ZSH_HIGHLIGHT_STYLES[smart-files:permissiondenied]:=fg=red}

_zsh_highlight_highlighter_smart_files_predicate() {
    _zsh_highlight_buffer_modified
}

_zsh_highlight_highlighter_smart_files_paint() {
    emulate -L zsh
    local tokens cmd target
    typeset -a cmd_words
    cmd_words=(${(z)BUFFER})
    [[ ${#cmd_words} -lt 2 ]] && return

    cmd="${cmd_words[1]}"

    # Get each non-flag argument
    for ((i = 2; i <= ${#cmd_words}; i++)); do
        target="${cmd_words[i]}"
        [[ "$target" = -* ]] && continue
        target="${target//[\'\"]/}"

        local pos=$(( ${#BUFFER} - ${#BUFFER:${#BUFFER} - ${#target}} ))
        local len=${#target}

        case "$target" in
            \~*) target="${HOME}${target#\~}" ;;
            /*) ;;
            *) target="$PWD/$target" ;;
        esac

        if [[ -e "$target" ]]; then
            if [[ ! -r "$target" || (! -w "$target" && "$cmd" != "cat" && "$cmd" != "less" && "$cmd" != "head" && "$cmd" != "tail") ]]; then
                _zsh_highlight_add_highlight $pos $((pos + len)) smart-files:permissiondenied
            else
                _zsh_highlight_add_highlight $pos $((pos + len)) smart-files:existingpath
            fi
        else
            # Don't highlight new paths for read-only commands
            if [[ "$cmd" != "cat" && "$cmd" != "less" && "$cmd" != "head" && "$cmd" != "tail" ]]; then
                _zsh_highlight_add_highlight $pos $((pos + len)) smart-files:newpath
            fi
        fi
    done
}
