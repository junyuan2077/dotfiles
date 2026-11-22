# Custom Tokyo Night theme for Bash (Extracted from Kirov)
export LS_COLORS="di=38;5;111:ex=38;5;114:ln=38;5;122:so=38;5;135:pi=38;5;135:bd=38;5;179:cd=38;5;179:or=48;5;204;38;5;15:mi=48;5;204;38;5;15"

parse_git_branch() {
    if type __git_ps1 >/dev/null 2>&1; then
        __git_ps1 " \[\e[38;5;179m\]git:(\[\e[38;5;204m\]%s\[\e[38;5;179m\])\[\e[0m\]"
    else
        local branch
        branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
        if [ -n "$branch" ]; then
            echo " \[\e[38;5;179m\]git:(\[\e[38;5;204m\]${branch}\[\e[38;5;179m\])\[\e[0m\]"
        fi
    fi
}

export PS1='\[\e[1m\e[38;5;135m\]\u\[\e[0m\]\[\e[38;5;196m\] ☭ \[\e[0m\]\[\e[1m\e[38;5;122m\]\h\[\e[0m\] \[\e[1m\e[38;5;111m\]\W\[\e[0m\]$(parse_git_branch) \[\e[1m\e[38;5;204m\]❯\[\e[0m\] '

update_bash_ps2() {
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
PROMPT_COMMAND="update_bash_ps2${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
update_bash_ps2
