# ASD-STE100 — agent guidelines

## Workspace layout (read first)

This repository is one of three that must exist in `~/Apps`. An agent that reads this file must make sure all three clones are present before other work.

| Path | Remote |
|---|---|
| `~/Apps/000-dotfiles` | `https://github.com/kairin/000-dotfiles.git` |
| `~/Apps/ASD-STE100` | `https://github.com/kairin/ASD-STE100.git` |
| `~/Apps/tmux-cheat-sheet` | `https://github.com/kairin/tmux-cheat-sheet.git` |

`~/Apps` is a workspace directory. It is not a git repository.

Before any other work:

1. Make sure each path exists and is a git clone.
2. If a path does not exist, clone it from the remote in the table.
3. If `~/Apps/000-dotfiles` exists, run `~/Apps/000-dotfiles/scripts/ensure-workspace-layout.sh`.
4. If `000-dotfiles` does not exist, clone it first. Then run the command.

The script creates `~/Apps/AGENTS.md`, `~/Apps/CLAUDE.md`, and `~/Apps/GEMINI.md` as symlinks to `~/Apps/000-dotfiles/AGENTS.md`.

`CLAUDE.md` and `GEMINI.md` in this repository are compatibility symlinks to this file.

## Writing rule

1. LANGUAGE: Write all prose in ASD-STE100 Simplified Technical English.
2. Use the `ste-writing` skill for the rules.
3. Check each draft with `uv run ste-lint.py <file>` next to the skill file.
4. SCOPE: This rule applies to prose. It does not apply to code, identifiers, or command syntax.
5. SCOPE: This rule also applies to comments made in code.

The checker is an anti-slop denylist. A lint pass is not Issue 9 conformance.

Source files live in this repository. On this owner's machines, `000-dotfiles`
`./setup apply` delivers the skill to Claude Code, Grok Build, Antigravity,
Hermes, Pi, and Codex when that CLI is installed.
