#!/bin/bash
# Dotfiles setup script - syncs Claude configuration across machines

DOTFILES_DIR="$HOME/dotfiles"

echo "🔧 Setting up dotfiles..."

# Backup existing files
if [ -f ~/.claude/CLAUDE.md ] && [ ! -L ~/.claude/CLAUDE.md ]; then
  echo "📦 Backing up existing CLAUDE.md..."
  cp ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)
fi

# Remove existing file/symlink if present
if [ -e ~/.claude/CLAUDE.md ] || [ -L ~/.claude/CLAUDE.md ]; then
  rm ~/.claude/CLAUDE.md
fi

# Create symlinks
echo "🔗 Creating symlinks..."
ln -sf "$DOTFILES_DIR/claude/CLAUDE.md" ~/.claude/CLAUDE.md

# Verify
if [ -L ~/.claude/CLAUDE.md ]; then
  echo "✅ Claude configuration synced!"
  echo "   ~/.claude/CLAUDE.md -> $DOTFILES_DIR/claude/CLAUDE.md"
  echo ""
  echo "Verification:"
  file ~/.claude/CLAUDE.md
else
  echo "❌ Failed to create symlink"
  exit 1
fi
