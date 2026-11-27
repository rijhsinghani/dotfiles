# Dotfiles

Personal configuration files synced across an iMac and a MacBook Pro. Right now the only managed file is the global Claude Code instructions (`CLAUDE.md`). iCloud Drive is the primary sync; this git repo is a manual backup and history.

## Where things live

- `README.md`: setup, how the sync works, and how to verify it. Read it first.
- `setup.sh`: setup script for a new machine. Per the README, it links `~/.claude/CLAUDE.md` to the iCloud copy.
- `claude/CLAUDE.md`: git snapshot of the global Claude Code instructions. The live source is the iCloud copy, not this file.
- `.gitignore`: keeps secrets and local files out of the repo.

## Running and checking

- Set up a machine: `./setup.sh` from the repo root.
- No automated tests or linters are defined in this repo.
- Verify the sync with the commands in the "Verify Sync" section of `README.md`: `file ~/.claude/CLAUDE.md` should show a symlink, and `md5 ~/.claude/CLAUDE.md` should match on both machines.

## Rules not to break

- Never commit credentials, tokens or secrets. They live in `~/.credentials.env`, which stays out of the repo.
- Treat the iCloud copy of `CLAUDE.md` as the source of truth. To record history, copy it into `claude/CLAUDE.md` as described in `README.md`. Do not edit the snapshot and expect iCloud to pick it up.
- Do not replace the `~/.claude/CLAUDE.md` symlink with a regular file.
- If you change what `setup.sh` does or which files are managed, update the table and text in `README.md` too.

## Deeper docs

- [README.md](README.md): full setup and sync workflow.
- [claude/CLAUDE.md](claude/CLAUDE.md): the Claude Code global instructions being managed.
