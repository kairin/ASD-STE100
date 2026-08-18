# Implementation Plan: ASD-STE100 standing writing rule

**Branch**: `001-ste-standing-rule` | **Date**: 2026-08-18 | **Spec**: [spec.md](./spec.md) (revision 2)

**Input**: Feature specification from `specs/001-ste-standing-rule/spec.md`

## Summary

Give the gateway wrapper one extra argument so gateway sessions carry the rule
in the system prompt. Put the same rule in the agent instruction file, which
covers the plain command, the editor, scripts, and subagents. Then correct the
repo so the skill teaches categories instead of word lists. The owner types no
argument to get any of this.

## Technical Context

**Language/Version**: Bash for the wrapper. Markdown for the rule, the skill, and
the docs. Python 3 standard library for the checker, run through `uv`.

**Primary Dependencies**: `uv` for the checker. `jq` for settings reads. No new
package.

**Storage**: Files only.

**Testing**: Observation. Each success criterion is one command whose output a
reader checks. See [quickstart.md](./quickstart.md).

**Target Platform**: One Linux workstation. Claude Code v2.1.234. A LiteLLM
gateway on 127.0.0.1:4000 reached through `~/.local/bin/claude-gw`.

**Project Type**: One repo holding an agent skill, a checker script, and docs,
plus machine wiring outside the repo.

**Performance Goals**: Not applicable. The rule adds about five lines per request.

**Constraints**: Six requirements are non-negotiable: FR-012 through FR-017.

**Scale/Scope**: One script gains about 10 lines. One instruction file gains
about 5. Three symlinks. About 30 changed lines across two repo files. Two
provenance cleanups, one deletion, one licence.

## Constitution Check

*GATE: must pass before Phase 0. Re-checked after Phase 1.*

`.specify/memory/constitution.md` is still the unfilled template. Every
principle slot holds a placeholder. No project principle exists to check against.

**Result: PASS, vacuously.** Recorded rather than hidden. Run
`/speckit-constitution` before the next feature if principles are wanted.
Writing one for a change this size would cost more than the change.

Post-Phase-1 re-check: unchanged.

## Project Structure

### Documentation (this feature)

```text
specs/001-ste-standing-rule/
├── spec.md              # revision 2
├── plan.md              # this file
├── research.md          # the three measurements that settled the design
├── quickstart.md        # the validation guide, one section per success criterion
├── checklists/
│   └── requirements.md
└── tasks.md             # /speckit-tasks output (not created here)
```

`data-model.md` is not generated. The feature has no data entities, no fields,
and no state transitions. The spec's Key Entities are three documents and one
shell script, named below.

`contracts/` is not generated. The repo exposes no API and no endpoint. The one
interface that does change is the wrapper's argument surface, which is small
enough to state here: `claude-gw`, `claude-gw --offload`, `claude-gw --check`,
and any Claude Code argument passed through untouched.

### Files this feature touches

```text
# in this repo
ste-system-append.md          # NEW. The rule, about 5 lines. One copy
ste-writing-skill.md          # 7 edits, target ~107 lines, cap 115
README.md                     # new "Why this works"; enforcement section replaced
ste-lint.py                   # threshold decision, see Open Questions
before-after-samples.md       # video framing removed
experiment-results.md         # video framing and dead path removed
run-openai.py                 # see Open Questions
LICENSE                       # NEW

# outside this repo
~/Apps/000-dotfiles/local-bin/claude-gw   # edited FIRST
~/.local/bin/claude-gw                    # mirrored from the above
~/.claude/ste-system-append.md            # symlink into this repo
~/.claude/skills/ste-writing/SKILL.md     # symlink to ste-writing-skill.md
~/.claude/CLAUDE.md                       # the floor
```

**Structure Decision**: The repo stays flat; eight files need no tree. The rule
text lives once, in the repo, and the machine links to it, so the wrapper and
the floor cannot drift apart. Machine files are mirrored to the configuration
repo of record, because a spec naming `claude-gw` and 127.0.0.1:4000 cannot be
satisfied from a bare clone of this repo elsewhere.

## The wrapper change

Replace only the final `exec` line. Every `export` above it stays untouched.

```bash
APPEND="$HOME/.claude/ste-system-append.md"
ARGS=()
if [ -r "$APPEND" ]; then
  case " $* " in
    *" --append-system-prompt "*|*" --append-system-prompt-file "*|*" --system-prompt "*) ;;
    *) ARGS+=(--append-system-prompt-file "$APPEND") ;;
  esac
fi
exec "$HOME/.local/bin/claude" ${ARGS[@]+"${ARGS[@]}"} "$@"
```

Three details that are load-bearing:

- `${ARGS[@]+"${ARGS[@]}"}` is mandatory. The script runs under `set -euo
  pipefail`, where expanding an empty array aborts it.
- The `case` guard satisfies FR-009. The two append arguments cannot both apply,
  so the wrapper steps aside when the caller supplies one.
- The offload branch shifts its own argument before this point, so `$*` is
  already clean.

**The check branch goes AFTER the mode branch, not before.** Placing it first
would report the wrong address, because the mode branch is what sets it. After
the mode branch, `claude-gw --check` reports subscription state and
`claude-gw --offload --check` reports offload state, both correctly. It prints
whether `$APPEND` resolves, the mode, and the exported address, then exits 0
without `exec`.

## Implementation phases

**Phase A: the rule.** Write `ste-system-append.md` in the repo. Link it to
`~/.claude/ste-system-append.md`. Add the matching section to `~/.claude/CLAUDE.md`,
backing that file up first.

**Phase B: the skill install.** Create `~/.claude/skills/ste-writing/` and link
three files into it. `SKILL.md` is the target name, not the repo filename.

**Phase C: the wrapper.** Edit the `000-dotfiles` copy, mirror it, then verify
both match and the script parses.

**Phase D: the skill content.** Seven edits, net about +9 lines.

**Phase E: README and provenance.** The new section, the replaced section, the
`uv run` corrections, the two cleanups, the licence.

**Phase F: verification.** Run [quickstart.md](./quickstart.md). All nine
success criteria pass before any commit.

**Phase G: mirror and commit.** Commit the repo. Commit the wrapper change in
`000-dotfiles`. Never run its apply step.

A and B are independent. C depends on A, because the wrapper reads the file A
creates. D and E are independent of everything. F is last before G.

## Open questions for the owner

`/speckit-tasks` must carry these as decisions, not as work.

1. **`run-openai.py`**: delete it, or keep it with a header stating it cannot
   run? Its `prompts.json` and four condition prompts were never published.
   FR-021 permits either. Deleting removes 85 dead lines; keeping preserves the
   method as a reference.
2. **The sentence-length gap**: raise the checker's flavored threshold to 25 to
   match the skill, or leave it at 20 and footnote the bias? FR-018 permits
   either. Raising makes the two agree but stops the repo's headline 74% figure
   being reproducible with the shipped checker. Footnoting keeps the number
   reproducible and admits the skill is looser than its own measurement.

## Implementer traps

Carry into `tasks.md` word for word.

1. `--append-system-prompt-file` is absent from `--help` but real. Do not
   improvise when you cannot find it.
2. Change ONLY the final `exec` line of `claude-gw`. Never touch its `export`
   lines. Edit the `000-dotfiles` copy first, mirror, then verify both match.
3. Do not wrap `~/.local/bin/claude`. It is a symlink an auto-update repoints.
4. Do not hand-author `spec.md`, `plan.md`, `tasks.md` or `constitution.md`.
5. Do not run bare `python3`. A uv-guard hook denies it. Use `uv run`.
6. Link the skill as `SKILL.md`, not `ste-writing-skill.md`.
7. Delete means delete. Git history is the archive.
8. Use `${ARGS[@]+"${ARGS[@]}"}`. Under `set -u` a bare empty array expansion
   aborts the script.

## Complexity Tracking

No constitution gate was violated, because none is defined.

One complexity is accepted and recorded here instead: the feature changes files
in three places (this repo, `~/.claude`, and the configuration repo). A single
location would be simpler, but none satisfies both "the machine applies the
rule" and "another machine can reproduce it". The rule text still exists only
once, which is what prevents drift.
