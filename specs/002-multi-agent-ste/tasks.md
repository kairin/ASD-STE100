# Tasks: Multi-agent STE rule

**Feature**: `specs/002-multi-agent-ste` | **Spec**: [spec.md](./spec.md) | **Plan**: [plan.md](./plan.md)

One agent runs this file from start to end. Content repo first. `000-dotfiles` second.

## Phase 1: Setup

- [x] T001 Confirm branch is `20260906-133228` in `~/Apps/ASD-STE100` and feature dir is `specs/002-multi-agent-ste`
- [x] T002 [P] Record installed CLIs: `command -v claude grok agy hermes pi codex`

---

## Phase 2: Foundational

Agent-neutral five-line rule. Blocks every story.

- [x] T003 Rewrite `ste-system-append.md` so it names skill `ste-writing` and checker `uv run ste-lint.py` next to the loaded skill. No `~/.claude/` or other home path
- [x] T004 Change the Verify command in `ste-writing-skill.md` to `uv run ste-lint.py` next to the skill. No `~/.claude/` path. Keep the 20-word footnote
- [x] T005 Search `ste-senior-engineer-prompt.md` for one-agent home paths and remove any

**Checkpoint**: `rg '~/.claude/|~/.grok/|~/.hermes/|~/.gemini/|~/.agents/' ste-system-append.md ste-writing-skill.md ste-senior-engineer-prompt.md` finds nothing.

---

## Phase 3: User Story 3 - Paths and install name no single agent (P2)

**Goal**: README and skill are usable on every harness.

**Independent Test**: README install names `000-dotfiles` apply. Content files have no one-agent home path.

- [x] T006 [US3] Rewrite the README title and intro in `README.md` so the skill is not Claude-only
- [x] T007 [US3] Replace the Install section in `README.md`. Supported path is `000-dotfiles` `./setup apply` or `sync`. Do not present `ln -s` into one agent's skills directory as the supported path
- [x] T008 [US3] Rewrite "Standing rule outside the skill trigger" in `README.md` so it names Claude SessionStart, Grok home rules, and Antigravity global instructions, plus the skill floor for all six CLIs
- [x] T009 [US3] Add `AGENTS.md` at the repo root with the five-line rule from `ste-system-append.md`

---

## Phase 4: User Story 4 - Claims match the checker (P2)

**Goal**: Honesty statements.

**Independent Test**: README and skill say denylist. Experiment table says checker-compliance, n=1. Recurring-errors is a reference list.

- [x] T010 [P] [US4] Add the denylist / not-Issue-9-conformance statement to `ste-writing-skill.md` (Scope or Verify)
- [x] T011 [P] [US4] Add the same statement to `README.md`
- [x] T012 [P] [US4] Relabel the headline table in `experiment-results.md` as checker-compliance, one generation per cell, not comprehension
- [x] T013 [P] [US4] Fix `LICENSE` so `ste-recurring-errors.md` is a reference list, not linter input
- [x] T014 [US4] Run `uv run ste-lint.py README.md` and keep `per100w` under 2.5

---

## Phase 5: User Story 2 - Skill on every harness (P1)

**Goal**: `000-dotfiles` apply writes the portable dest and vendor dests.

**Independent Test**: After apply, `~/.agents/skills/ste-writing/SKILL.md` and the Claude and Agy vendor copies exist.

Work in `~/Apps/000-dotfiles` on a `YYYYMMDD-HHMMSS` branch. Do not commit to `main`.

- [x] T015 [US2] Run `~/Apps/000-dotfiles/scripts/sync-ste-writing.sh` so `skills/ste-writing/` matches this repo
- [x] T016 [US2] Confirm `skill.ste-writing` in `dotfiles-manifest.json` still uses `kind: skill` and default adapters. If portable dest is missing after a dry plan, fix apply in `dotfiles_tools/agent_clis.py` / installer so `~/.agents/skills/ste-writing/` is written when any of the six CLIs is on PATH
- [x] T017 [US2] Extend `tests/test_skill_kind.py` so a grok-only host writes `~/.agents/skills/ste-writing` and an agy-only host also writes `~/.gemini/config/skills/ste-writing`
- [x] T018 [US2] Run `uv run python -m unittest tests.test_skill_kind` in `~/Apps/000-dotfiles`

---

## Phase 6: User Story 1 - Standing rule without a flag (P1)

**Goal**: Grok home rule and Antigravity pointer. Claude hook stays.

**Independent Test**: Fresh `claude -p`, Grok session, and `agy` session each name ASD-STE100 with no flag.

- [x] T019 [US1] Add `grok/rules/ste-writing.md.template` in `~/Apps/000-dotfiles` with the same text as this repo's `ste-system-append.md`
- [x] T020 [US1] Add manifest entry `grok.ste-rule` in `dotfiles-manifest.json` targeting `.grok/rules/ste-writing.md`, skipped when `grok` is not on PATH
- [x] T021 [US1] Point `scripts/sync-ste-writing.sh` at the grok rules template so it stays in sync with `ste-system-append.md`
- [x] T022 [US1] Add a short STE pointer to `gemini/GEMINI.md.template` that names the skill `ste-writing` and does not hard-code `~/.claude/`
- [x] T023 [US1] Update the STE section in `claude/CLAUDE.md.template` so it names the portable dest and vendor copies, not Claude-only
- [x] T024 [US1] Rewrite `docs/operations/ste-writing-setup.md` dest table. Drop "Claude append stays Claude-only"
- [x] T025 [US1] Add `tests/test_ste_standing_rule.py` covering: grok rules dest when grok present; skipped when grok missing; Gemini pointer present
- [x] T026 [US1] Run `./setup apply` (or `sync --yes`) from `~/Apps/000-dotfiles` so dests land on this machine
- [x] T027 [US1] Verify SC-001 and SC-002 from [quickstart.md](./quickstart.md)

---

## Phase 7: Polish

- [x] T028 Run SC-003, SC-004, SC-005 from [quickstart.md](./quickstart.md)
- [x] T029 Do not invent Hermes, Pi, or Codex standing-rule dests. Do not claim those CLIs were tested
- [x] T030 Ask the owner before any commit or push. Never commit to `main`

## Dependencies

- Phase 2 blocks Phase 3–6. The five-line rule is the source `000-dotfiles` copies.
- Phase 3 and Phase 4 are this repo only. They can run together after Phase 2.
- Phase 5 and Phase 6 are `000-dotfiles`. Phase 5 should land dests before Phase 6 verify.
- Phase 7 is last.

## Suggested MVP

Phase 1, Phase 2, Phase 3, Phase 4. That makes this repo honest and agent-neutral. Phase 5 and 6 then deliver the rule to the six harnesses.

## Parallel work

- T004 and T005 after T003.
- T010, T011, T012, T013 together.
- T006–T008 touch `README.md` and must be sequential.
