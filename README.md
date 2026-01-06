# Dotfiles

Personal configuration files synced across iMac and MacBook Pro.

## 🚀 Quick Setup on New Machine

```bash
git clone https://github.com/sameerrijhsinghani/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

That's it! iCloud will automatically sync changes across all your Macs.

## 📁 Files Managed

| Source File | Symlinked To | Description |
|------------|--------------|-------------|
| `~/Library/Mobile Documents/com~apple~CloudDocs/.claude-config/CLAUDE.md` | `~/.claude/CLAUDE.md` | Claude Code global instructions (196 lines) |

## 🎯 How It Works

- **Primary sync**: iCloud Drive (automatic, zero-maintenance)
- **Backup/history**: This git repo (manual commits for version control)
- **Symlink**: `~/.claude/CLAUDE.md` → iCloud location

Edit `~/.claude/CLAUDE.md` on any Mac, and it auto-syncs to all others via iCloud. No git commands needed!

## 📝 Updating Configuration

Just edit the file normally:
```bash
# Edit on either machine
vim ~/.claude/CLAUDE.md

# iCloud syncs automatically within seconds
# No git commands required!
```

## 🔄 Optional: Save Git History

To keep version history (optional):

```bash
cd ~/dotfiles
cp ~/Library/Mobile\ Documents/com~apple~CloudDocs/.claude-config/CLAUDE.md claude/CLAUDE.md
git add claude/CLAUDE.md
git commit -m "Update Claude configuration: [describe change]"
git push
```

## ✅ Verify Sync

Run this on both machines to verify they're in sync:

```bash
# Should show symlink
file ~/.claude/CLAUDE.md

# Should show identical checksums on both machines
md5 ~/.claude/CLAUDE.md
```

## 🎯 What's Inside CLAUDE.md?

- CLI-first automation philosophy (gcloud, supabase, stripe, gh)
- Context7 MCP integration for up-to-date docs
- BMAD Method v6 workflow automation rules
- Google Cloud Run deployment standards (us-east4 region policy)
- Cloud Build secrets best practices
- Credentials storage rules (~/.credentials.env)
- Long-running project harness (features.json + claude-progress.txt)
- Local validation workflow requirements
- Raj Photo Video data model specifics

## 🛡️ Security Note

This repo does NOT contain credentials. All secrets live in `~/.credentials.env` (synced via iCloud, protected by .gitignore).
