# Guard 1: Skip silently if fzf is not installed on this machine
command -v fzf >/dev/null 2>&1 || return 0

# Clean compact UI (works in both fzf 0.44 and 0.60)
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Guard 2: Feature-detect v0.48+ (--bash) vs. older distro scripts (e.g. Ubuntu 24.04 apt 0.44.1)
if fzf --bash >/dev/null 2>&1; then
    eval "$(fzf --bash)"
else
    for _fzf_script in \
        /usr/share/doc/fzf/examples/key-bindings.bash \
        /usr/share/doc/fzf/examples/completion.bash \
        "$HOME/.fzf/shell/key-bindings.bash" \
        "$HOME/.fzf/shell/completion.bash"; do
        [ -r "$_fzf_script" ] && source "$_fzf_script"
    done
    unset _fzf_script
fi
