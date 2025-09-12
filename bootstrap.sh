#!/usr/bin/env bash
set -euo pipefail

: "${DOTFILES_REPO:=git@github.com:Fei-Wang/dotfiles.git}"
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
for b in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
  [ -x "$b" ] && eval "$("$b" shellenv)" && break
done
have brew || die "brew not on PATH after install."

# 2) chezmoi
have chezmoi || brew install -q chezmoi
# 可选：确保 git 存在
have git || brew install -q git

# 3) 已初始化 -> update
if chezmoi git -- rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  exec chezmoi update -a
fi

# 4) 初次初始化
args=(init --apply)
[ -n "${DOTFILES_BRANCH}" ] && args+=(--branch "${DOTFILES_BRANCH}")
[ -n "${DOTFILES_DEPTH}" ] && args+=(--depth "${DOTFILES_DEPTH}")
exec chezmoi "${args[@]}" "${DOTFILES_REPO}"
