#!/usr/bin/env bash
# bootstrap.sh — install Homebrew (if needed) -> install chezmoi -> init or update
set -euo pipefail

# ====== 可按需改成你的仓库（默认走 SSH；可用环境变量覆盖） ======
: "${DOTFILES_REPO:=git@github.com:Fei-Wang/dotfiles.git}"
# 可选：指定分支与浅克隆深度（留空则用默认分支；深度默认 1）
: "${DOTFILES_BRANCH:=}"
: "${DOTFILES_DEPTH:=1}"

have() { command -v "$1" >/dev/null 2>&1; }
die() {
  echo "[ERR] $*" >&2
  exit 1
}

# 1) Homebrew
if ! have brew; then
  if have curl; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  elif have wget; then
    /bin/bash -c "$(wget -qO- https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    die "Need curl or wget to install Homebrew."
  fi
fi
# 把 brew 注入当前进程 PATH（不写入配置文件）
for b in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
  [ -x "$b" ] && eval "$("$b" shellenv)" && break
done
have brew || die "brew not on PATH after install."

# 2) chezmoi via brew
have chezmoi || brew install -q chezmoi

# 3) 若已初始化则更新，否则初始化
src="$(chezmoi source-path 2>/dev/null || true)"
if [ -n "$src" ] && [ -d "$src/.git" ]; then
  exec chezmoi update -a
fi

# 4) 初次初始化
args=(init --apply)
[ -n "$DOTFILES_BRANCH" ] && args+=(--branch "$DOTFILES_BRANCH")
[ -n "$DOTFILES_DEPTH" ] && args+=(--depth="$DOTFILES_DEPTH")
exec chezmoi "${args[@]}" "$DOTFILES_REPO"
