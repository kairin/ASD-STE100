# Research: multi-agent STE dests

Phase 0 output. Three dest questions. No question stays open.

---

## 1. Where does each harness load skills?

**Decision**: Use the dest map already in `000-dotfiles/dotfiles_tools/agent_clis.py`.

- Portable dest, when any of the six CLIs is installed: `~/.agents/skills/ste-writing/`
- Vendor dests, only when that CLI is on PATH: Claude `~/.claude/skills/ste-writing/`, Hermes `~/.hermes/skills/ste-writing/`, Antigravity `~/.gemini/config/skills/ste-writing/`
- Codex, Pi, and Grok scan the portable dest. Grok also scans `.agents/skills` at each tier and, by default, `~/.claude/skills` for compatibility.

**Rationale**: Measured on this machine and in `000-dotfiles` source. Grok's user guide lists those roots. Inventing `~/.grok/skills/ste-writing` as a machine-profile copy would fight the `000-dotfiles` rule that Speckit skills are project-local, not profile copies. The portable dest is the one dest all six can share.

**Alternatives considered**: Copy the skill into `~/.grok/skills/` as a vendor dest. Rejected. Grok already scans `~/.agents/skills`. Extra copies drift. On this machine the portable dest is missing after apply — that is a delivery bug to fix, not a reason to add a fourth copy.

---

## 2. Where does each harness take a standing rule?

**Decision**:

| Harness | Standing-rule dest | This feature |
|---|---|---|
| Claude Code | `~/.claude/ste-system-append.md` plus SessionStart hook | keep |
| Grok Build | `~/.grok/rules/ste-writing.md` (home rules, all projects) | add |
| Antigravity | pointer in `~/.gemini/GEMINI.md` | add |
| Hermes | unknown | skill floor only |
| Pi | unknown | skill floor only |
| Codex | unknown | skill floor only |

**Rationale**: Grok's user guide states `$GROK_HOME/rules/` (default `~/.grok/rules/`) is always scanned. That directory exists on this machine and is empty. Antigravity already has `gemini.global-instructions` in the `000-dotfiles` manifest. Claude's hook exists because `CLAUDE.md` is not the system prompt and can drop during compaction. Hermes, Pi, and Codex are not on this machine. Constitution IV and FR-013 forbid inventing a dest.

**Alternatives considered**: Put the five-line rule only in the skill description and rely on auto-invoke. Rejected. Auto-invoke is not a global-instruction surface. The first feature already measured that a skill trigger is not enough. Put the rule in every project's `AGENTS.md` via `./setup init`. Rejected as the only route: it misses sessions outside a scaffolded project. This repo still gains an `AGENTS.md` so a clone without `000-dotfiles` has a standing rule for harnesses that read that file.

---

## 3. What does "agent-neutral" mean in the content files?

**Decision**: The five-line rule names the skill `ste-writing` and the checker as `uv run ste-lint.py` next to the skill file the agent loaded. It does not name `~/.claude/skills/` or any other home path. The README names `000-dotfiles` apply as the supported install and lists the six harnesses. A manual `ln -s` is not the supported path.

**Rationale**: Constitution III. Hard-coded Claude paths make Grok and Antigravity point at the wrong tree.

**Alternatives considered**: Keep Claude paths and add a sentence "or your agent's skills dir". Rejected. One wrong path is still a wrong path. Readers copy the first command they see.

---

## What this means for the design

- Content change is small and must land first, so `sync-ste-writing.sh` can vendor it.
- Delivery change is in `000-dotfiles`: fix or confirm portable dest apply, add Grok rules file, add Gemini pointer, extend tests.
- Runtime verify on this machine: Claude Code, Grok Build, Antigravity. Three CLIs only.
