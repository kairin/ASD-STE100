# STE payload and delivery map

This repository is the source for one reusable STE payload.
The downstream repository packages three files for automatic delivery.
Two files remain manual because they are not skill files.
This work is tracked in
[ASD-STE100 issue #10](https://github.com/kairin/ASD-STE100/issues/10).

## Payload files

The five files form one payload. The synchronizer copies the first three.
The last two files remain manual.

| Role | Source file | Package file | Delivery |
|---|---|---|---|
| Skill | `ste-writing-skill.md` | `SKILL.md` | Automatic |
| Checker | `ste-lint.py` | `ste-lint.py` | Automatic |
| Reference | `ste-recurring-errors.md` | `ste-recurring-errors.md` | Automatic |
| Standing rule | `ste-system-append.md` | None | Manual |
| Optional prompt | `ste-senior-engineer-prompt.md` | None | Manual |

`ste-lint.py` is a denylist check, not full Issue 9 conformance.
The checker does not load the approved dictionary.

`ste-system-append.md` has no automatic destination. Add its text to a global
instruction file when a tool requires the standing rule.

`ste-senior-engineer-prompt.md` has no automatic destination. Pass it as a
full system prompt when a tool requires the complete prompt.

## Skill destinations

The portable skill directory is common to the four preferred tools.
The package files use the same directory as `SKILL.md`.

| Tool | Portable skill directory | Vendor skill directory |
|---|---|---|---|
| Hermes | `~/.agents/skills/ste-writing/` | `~/.hermes/skills/ste-writing/` |
| Pi | `~/.agents/skills/ste-writing/` | None |
| OpenAI Codex CLI | `~/.agents/skills/ste-writing/` | None |
| Google Antigravity (`agy`) | `~/.agents/skills/ste-writing/` | `~/.gemini/config/skills/ste-writing/` |

The synchronizer refreshes only the three automatic package files.
The downstream manifest copies those files to active destinations.
It selects destinations from installed tool commands.
Do not claim a runtime result for a tool that is not installed.

## Comparison checks

Run the payload check from this repository:

```bash
DOTFILES_REPO=../000-dotfiles scripts/check-ste-payload.sh
```

The check compares the three automatic source files with their package files.
It then compares those files with each required installed destination.
The check also makes sure that the two manual files have no package copy.

Set `STE_DELIVERY_HOME` when the destination home is not the current home.
The check requires the portable destination when a preferred tool is installed.
It requires a vendor destination only for an installed tool that uses one.
