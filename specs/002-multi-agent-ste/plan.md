# Implementation Plan: Multi-agent STE rule

**Branch**: `20260906-133228` | **Date**: 2026-09-06 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `specs/002-multi-agent-ste/spec.md`

**Note**: Git branch is `20260906-133228`. Spec directory is `002-multi-agent-ste`. They are independent.

## Summary

Make the ASD-STE100 writing rule usable on Claude Code, Grok Build, Antigravity, Hermes, Pi, and Codex. This repo stays the single source and drops every one-agent home path. `000-dotfiles` delivers the skill to the portable dest plus vendor dests, keeps the Claude SessionStart hook, and adds a Grok home rule and an Antigravity global-instruction pointer. Hermes, Pi, and Codex get the skill floor only.

## Technical Context

**Language/Version**: Markdown for the skill, the five-line rule, and the docs. Python 3 standard library for the checker, run through `uv`. Bash only inside `000-dotfiles` templates already in that shape.

**Primary Dependencies**: `uv` for the checker. `000-dotfiles` `kind: skill` apply. No new package.

**Storage**: Files only.

**Testing**: Observation on this machine for Claude Code, Grok Build, and Antigravity. `000-dotfiles` unittest for dests (those tests already exist for `kind: skill`; add standing-rule dest tests). No runtime test for Hermes, Pi, or Codex on this machine.

**Target Platform**: One Linux workstation. Installed CLIs: `claude`, `grok`, `agy`. Not installed: `hermes`, `pi`, `codex`.

**Project Type**: Content repo plus machine delivery in a second repo, same split as `001-ste-standing-rule`.

**Performance Goals**: Not applicable.

**Constraints**: Constitution v1.0.0. FR-005 forbids one-agent home paths in content files. FR-013 forbids invented standing-rule dests for Hermes, Pi, and Codex. FR-014 forbids claiming a runtime test that did not run.

**Scale/Scope**: A handful of content files in this repo. A handful of templates, one sync-script dest, and tests in `000-dotfiles`.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Result |
|---|---|
| I. Prose Rule | PASS. This feature does not rewrite identifiers. |
| II. Denylist Checker | PASS. Honesty text is in scope. Dictionary load is out of scope. |
| III. One Content Repo | PASS. Content stays here. Delivery stays in `000-dotfiles`. Paths become agent-neutral. |
| IV. Standing Rule | PASS. Claude hook stays. Grok home rule and Antigravity pointer are added. Skill floor covers all six. |
| V. Speckit Authors Specs | PASS. This file is `/speckit-plan` output. |

**Result: PASS.** Post-Phase-1 re-check: unchanged.

## Project Structure

### Documentation (this feature)

```text
specs/002-multi-agent-ste/
├── spec.md
├── plan.md              # this file
├── research.md          # Phase 0
├── data-model.md        # Phase 1 (documents, not a database)
├── quickstart.md        # Phase 1
└── tasks.md             # /speckit-tasks (not created here)
```

`contracts/` is not generated. This repo exposes no API.

### Files this feature touches

```text
# in this repo
ste-system-append.md          # agent-neutral five-line rule
ste-writing-skill.md          # Verify command; drop Claude-only wording if present
ste-senior-engineer-prompt.md # drop any one-agent home path
README.md                     # multi-agent; 000-dotfiles install; honesty
experiment-results.md         # label table as checker-compliance, n=1
LICENSE                       # recurring-errors is a reference list
AGENTS.md                     # NEW. Five-line rule for harnesses that read AGENTS.md

# in 000-dotfiles (second PR, after this repo lands)
skills/ste-writing/           # vendored from this repo via sync-ste-writing.sh
claude/ste-system-append.md.template
grok/rules/ste-writing.md.template          # NEW. Same five-line text
gemini/GEMINI.md.template                   # STE pointer
claude/CLAUDE.md.template                   # STE section names portable dest
scripts/sync-ste-writing.sh                 # also vendor grok rules file
dotfiles-manifest.json                      # grok.ste-rule entry
docs/operations/ste-writing-setup.md
tests/test_skill_kind.py                    # extend dest coverage
tests/test_ste_standing_rule.py             # NEW. grok rules + gemini pointer skip when CLI missing
```

**Structure Decision**: This repo stays flat. No per-agent skill tree here. `000-dotfiles` remains the copier.

## Complexity Tracking

No constitution gate was violated.

One complexity is accepted: two repositories. A single repo cannot both be the public content source and the machine profile. The five-line rule still exists only once in this repo. `000-dotfiles` copies it.
