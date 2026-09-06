# Data model: Multi-agent STE rule

No database. The spec's entities are files and dests.

## Five-line rule

- **Identity**: one file in this repo (`ste-system-append.md`).
- **Fields**: standard name, skill name, checker command, prose scope.
- **Rules**: no one-agent home path. Checker command is `uv run ste-lint.py` next to the loaded skill.
- **Copies**: `000-dotfiles` writes this text to Claude's append file and to Grok's home-rules file. Gemini/Agy global instructions get a pointer, not a second full copy, unless a pointer cannot load the file.

## Skill

- **Identity**: `ste-writing` directory (`SKILL.md`, `ste-lint.py`, `ste-recurring-errors.md`).
- **Source**: this repo (`ste-writing-skill.md` is the skill body).
- **Dests**: portable `~/.agents/skills/ste-writing/`; vendor copies for Claude, Hermes, Antigravity when that CLI is installed.
- **Rules**: Verify section uses the agent-neutral checker command.

## Checker

- **Identity**: `ste-lint.py`.
- **Output**: violations per 100 words, score version, mode.
- **Rules**: denylist. Does not load Issue 9. Honesty text in README and skill must match this.

## Harness

- **Name**: one of claude, grok, agy, hermes, pi, codex.
- **Installed**: CLI on PATH, or not.
- **Skill dest**: portable always (if any CLI installed); vendor dest if listed in `VENDOR_ADAPTERS` and CLI present.
- **Standing dest**: present only for claude, grok, agy in this feature.
- **Test**: runtime session check only when installed.

## Delivery record

- **Tool**: `000-dotfiles` apply / doctor.
- **States**: current, missing, drifted, skipped (CLI not installed).
- **Invariant**: skipped MUST NOT be reported as a failed runtime test.
