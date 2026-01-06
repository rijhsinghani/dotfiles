#!/bin/bash
# Dotfiles setup script - syncs Claude configuration via iCloud

ICLOUD_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/.claude-config"

echo "🔧 Setting up dotfiles with iCloud sync..."

# Check if iCloud is available
if [ ! -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs" ]; then
  echo "❌ iCloud Drive not found. Is iCloud enabled on this Mac?"
  exit 1
fi

# Create iCloud config directory if needed
mkdir -p "$ICLOUD_DIR"

# Backup existing files
if [ -f ~/.claude/CLAUDE.md ] && [ ! -L ~/.claude/CLAUDE.md ]; then
  echo "📦 Backing up existing CLAUDE.md..."
  cp ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)

  # Copy to iCloud if it doesn't exist there yet
  if [ ! -f "$ICLOUD_DIR/CLAUDE.md" ]; then
    echo "📤 Uploading existing CLAUDE.md to iCloud..."
    cp ~/.claude/CLAUDE.md "$ICLOUD_DIR/CLAUDE.md"
  fi
fi

# Remove existing file/symlink if present
if [ -e ~/.claude/CLAUDE.md ] || [ -L ~/.claude/CLAUDE.md ]; then
  rm ~/.claude/CLAUDE.md
fi

# Create symlink to iCloud
echo "🔗 Creating symlink to iCloud Drive..."
ln -sf "$ICLOUD_DIR/CLAUDE.md" ~/.claude/CLAUDE.md

# Verify
if [ -L ~/.claude/CLAUDE.md ]; then
  echo "✅ Claude configuration synced via iCloud!"
  echo "   ~/.claude/CLAUDE.md -> $ICLOUD_DIR/CLAUDE.md"
  echo ""
  echo "📱 This file now auto-syncs across all your Macs via iCloud"
  echo ""
  echo "Verification:"
  file ~/.claude/CLAUDE.md
  echo ""
  md5 ~/.claude/CLAUDE.md
else
  echo "❌ Failed to create symlink"
  exit 1
fi
