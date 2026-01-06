# Dotfiles

Personal configuration files synced across iMac and MacBook Pro.

## 🚀 Quick Setup on New Machine

```bash
git clone https://github.com/sameerrijhsinghani/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

## 📁 Files Managed

| Source File | Symlinked To | Description |
|------------|--------------|-------------|
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Claude Code global instructions (196 lines) |

## 📝 Updating Configuration

After editing `~/.claude/CLAUDE.md` on any machine:

```bash
cd ~/dotfiles
git add claude/CLAUDE.md
git commit -m "Update Claude configuration"
git push
```

## 🔄 Syncing to Other Machine

```bash
cd ~/dotfiles
git pull
./setup.sh  # Re-run to ensure symlinks are correct (optional)
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
