# Custom Tokyo Night theme for Bash (Extracted from Kirov)
export LS_COLORS="di=38;5;111:ex=38;5;114:ln=38;5;122:so=38;5;135:pi=38;5;135:bd=38;5;179:cd=38;5;179:or=48;5;204;38;5;15:mi=48;5;204;38;5;15"

__kirov_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        printf ' \\[\\e[38;5;179m\\]git:(\\[\\e[38;5;204m\\]%s\\[\\e[38;5;179m\\])\\[\\e[0m\\]' "$branch"
    fi
}

__kirov_update_prompt() {
    local git_part
    git_part=$(__kirov_git_branch)

    # Build PS1 inside PROMPT_COMMAND so \[...\] in git_part is parsed by Bash!
    PS1="\[\e[1m\e[38;5;135m\]\u\[\e[0m\]\[\e[38;5;196m\] ☭ \[\e[0m\]\[\e[1m\e[38;5;122m\]\h\[\e[0m\] \[\e[1m\e[38;5;111m\]\W\[\e[0m\]${git_part} \[\e[1m\e[38;5;204m\]❯\[\e[0m\] "

    # Align PS2 continuation prompt with primary prompt
    local exp="${PS1@P}"
    local clean
    clean=$(printf '%s' "$exp" | sed -E $'s/\x01[^\x02]*\x02//g; s/\x1B\[[0-9;]*[a-zA-Z]//g')
    local width=${#clean}
    local prefix_w=$(( width - 2 ))
    if [ $prefix_w -ge 4 ]; then
        local spaces=$(( prefix_w - 4 ))
        local pad
        printf -v pad '%*s' "$spaces" ''
        PS2="\[\e[38;5;238m\]${pad}∙∙∙ \[\e[1m\e[38;5;204m\]❯\[\e[0m\] "
    else
        local pad
        printf -v pad '%*s' "$prefix_w" ''
        PS2="${pad}\[\e[1m\e[38;5;204m\]❯\[\e[0m\] "
    fi
}

if [[ ";${PROMPT_COMMAND:-};" != *";__kirov_update_prompt;"* ]]; then
    PROMPT_COMMAND="__kirov_update_prompt${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
__kirov_update_prompt
