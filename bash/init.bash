_dotfiles_bash_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for _mod in prompt.bash fzf.bash; do
    [ -r "${_dotfiles_bash_dir}/${_mod}" ] && source "${_dotfiles_bash_dir}/${_mod}"
done

unset _dotfiles_bash_dir _mod
