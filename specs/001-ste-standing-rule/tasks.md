# Tasks: ASD-STE100 standing writing rule

**Feature**: `specs/001-ste-standing-rule` | **Spec**: revision 2 | **Plan**: [plan.md](./plan.md)

One agent runs this file from start to end. Read the traps first.

## Read this before you start

1. `--append-system-prompt-file` is absent from `--help` but real. Do not
   improvise when you cannot find it.
2. Change ONLY the final exec line of claude-gw. Never touch its export lines.
   Edit the 000-dotfiles copy first, mirror, then verify both match.
3. Do not wrap `~/.local/bin/claude`. It is a symlink an auto-update repoints.
4. Do not hand-author spec.md, plan.md, tasks.md or constitution.md.
5. Do not run bare `python3`. A uv-guard hook denies it. Use `uv run`.
6. Link the skill as `~/.claude/skills/ste-writing/SKILL.md`, not the repo
   filename `ste-writing-skill.md`.
7. Delete means delete. Git history is the archive.
8. Use `${ARGS[@]+"${ARGS[@]}"}`. Under `set -u` a bare empty array expansion
   aborts the script.

Two decisions are already made. Delete `run-openai.py`. Do not change
`ste-lint.py`, and footnote the length gap instead.

## Phase 1: Setup

- [x] T001 Back up `~/.claude/CLAUDE.md` to `~/.claude/CLAUDE.md.bak.$(date -u +%Y%m%dT%H%M%SZ)`
- [x] T002 [P] Record the gateway restart count with `systemctl --user show llm-gateway -p NRestarts`
- [x] T003 [P] Record the guard-hook count with `jq '.hooks.PreToolUse|length' ~/.claude/settings.json`

## Phase 2: Foundational

These block every user story. Finish them first.

- [x] T004 Write the rule, about 5 lines, to `ste-system-append.md` in the repo root
- [x] T005 Link `~/.claude/ste-system-append.md` to `~/Apps/ASD-STE100/ste-system-append.md`
- [x] T006 [P] Create `~/.claude/skills/ste-writing/` and link `SKILL.md` to `ste-writing-skill.md`
- [x] T007 [P] Link `ste-lint.py` and `ste-recurring-errors.md` into `~/.claude/skills/ste-writing/`
- [x] T008 Add a short "Writing style" section to `~/.claude/CLAUDE.md` that names the skill

## Phase 3: User Story 1, the rule applies with no argument (P1)

**Goal**: The gateway command with no argument puts the rule in the system prompt.

**Independent test**: Type `claude-gw -p` with a question. The answer names ASD-STE100.

- [x] T009 [US1] Replace the final exec line in `~/Apps/000-dotfiles/local-bin/claude-gw`
- [x] T010 [US1] Run `bash -n ~/Apps/000-dotfiles/local-bin/claude-gw` and fix any syntax error
- [x] T011 [US1] Copy the edited file to `~/.local/bin/claude-gw`
- [x] T012 [US1] Run `diff` on the two copies and confirm they match
- [x] T013 [US1] Confirm 2 `ANTHROPIC_BASE_URL` exports and 1 `ANTHROPIC_AUTH_TOKEN` export survive
- [x] T014 [US1] Verify SC-001 and SC-005 with the SC-001 section of [quickstart.md](./quickstart.md)

## Phase 4: User Story 2, the rule reaches subagents (P2)

**Goal**: A task subagent obeys the rule. No argument can reach one.

**Independent test**: Start one trivial subagent. Ask it which standard it obeys.

- [x] T015 [US2] Verify SC-001, subagent route, with the SC-001 section of [quickstart.md](./quickstart.md)

## Phase 5: User Story 3, the owner can see the state (P2)

**Goal**: The wrapper reports its state and exits, without starting a session.

**Independent test**: Run `claude-gw --check` with the rule file present and renamed.

- [x] T016 [US3] Add a `--check` branch to `~/Apps/000-dotfiles/local-bin/claude-gw`, AFTER the mode branch
- [x] T017 [US3] Mirror the file again, then re-run `bash -n` and `diff`
- [x] T018 [US3] Verify SC-006 with the SC-006 section of [quickstart.md](./quickstart.md)

The check branch goes after the mode branch. The mode branch sets the address
that the check branch reports.

## Phase 6: User Story 4, the skill teaches categories (P3)

**Goal**: The skill states a rule for each of the six habits.

**Independent test**: Give a session slop the skill never listed. The rewrite removes it.

- [x] T019 [US4] Add a slop-habit-to-rule map to `ste-writing-skill.md` after line 18
- [x] T020 [US4] Add a category test to the marketing rule on line 26
- [x] T021 [US4] Add the checker's hedge list to line 33
- [x] T022 [US4] Add the noun-suffix pattern to line 34
- [x] T023 [US4] Rule on the em dash on line 50 and cut the stale note
- [x] T024 [US4] Add one line that gives the 3 percent and 74 percent measurements
- [x] T025 [US4] Cut the duplicate word count on line 68
- [x] T026 [US4] Change `python3` to `uv run` on lines 75 and 76
- [x] T027 [US4] Footnote the length gap. The checker flags over 20 words in both modes
- [x] T028 [US4] Verify SC-008 with the SC-008 section of [quickstart.md](./quickstart.md)

## Phase 7: User Story 5, the repo explains itself (P3)

**Goal**: A reader learns why the standard works and meets no false claim.

**Independent test**: Follow the README from a clean copy. Every command runs.

- [x] T029 [P] [US5] Add "Why this works" to `README.md`: origin, habit-to-rule map, evidence
- [x] T030 [US5] Replace lines 66 to 99 of `README.md` with about 10 lines on the two routes
- [x] T031 [US5] Change `python3` to `uv run` on lines 62 and 63 of `README.md`
- [x] T032 [US5] Correct line 7 of `README.md`, which claims an install that never happened
- [x] T033 [US5] Delete `run-openai.py` and its row on line 22 of `README.md`
- [x] T034 [P] [US5] Remove the video frontmatter and "for on-screen use" from `before-after-samples.md`
- [x] T035 [P] [US5] Remove "say them on camera" and the dead path from `experiment-results.md`
- [x] T036 [P] [US5] Add `LICENSE` to the repo root
- [x] T037 [US5] Footnote the length gap in `README.md` as well
- [x] T038 [US5] Verify SC-007 and SC-009 with their sections of [quickstart.md](./quickstart.md)

## Phase 8: Polish and commit

- [x] T039 Verify SC-002 with its section of [quickstart.md](./quickstart.md). The restart count must not climb
- [x] T040 Verify SC-003 with its section of [quickstart.md](./quickstart.md)
- [x] T041 Verify SC-004 with its section of [quickstart.md](./quickstart.md). Expect 6 hook groups
- [x] T042 Commit the repo on `main`. Ask the owner before you push
- [x] T043 Commit the wrapper change in `~/Apps/000-dotfiles`. Never run its apply step

## Dependencies

- Phase 2 blocks Phase 3, 4 and 5. The wrapper reads the file T004 creates.
- Phase 3 blocks Phase 5. Both edit the same script.
- Phase 6 and Phase 7 depend on nothing. Run them at any time.
- Phase 8 is last.

## Parallel work

- T002 and T003 run together.
- T006 and T007 run together, after T005.
- T029, T034, T035 and T036 run together. They touch different files.
- Phase 6 and Phase 7 run together. They touch different files.

## Suggested MVP

Phase 1, Phase 2 and Phase 3. That gives the rule in the system prompt for
gateway sessions, and the floor for every other route. Phase 4 then proves the
subagent route without any new work.
