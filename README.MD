# dotfiles

Personal shell configuration, designed to be portable across machines.

## Structure

- `bash/init.bash` — Entrypoint that sources the Bash modules below.
- `bash/prompt.bash` — Tokyo Night prompt (`PS1`/`PS2` alignment, Git branch indicator, `LS_COLORS`).
- `bash/fzf.bash` — Guarded `fzf` integration (no-op if missing; supports both `fzf --bash` on v0.48+ and legacy distro scripts).

## Usage

Clone the repository and source `bash/init.bash` from `~/.bashrc`:

```bash
git clone git@github.com:junyuan2077/dotfiles.git ~/.dotfiles
echo '[ -r ~/.dotfiles/bash/init.bash ] && source ~/.dotfiles/bash/init.bash' >> ~/.bashrc
```
