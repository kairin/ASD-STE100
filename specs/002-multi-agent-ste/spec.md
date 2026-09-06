# Feature Specification: Multi-agent STE rule

**Feature Branch**: `002-multi-agent-ste`

**Created**: 2026-09-06

**Status**: Draft

**Input**: User description: "Make the ASD-STE100 writing rule usable on every coding-agent harness this owner runs through 000-dotfiles: Claude Code, Grok Build, Antigravity (agy), Hermes, Pi, and Codex. The owner must not type a flag to get the rule on a harness that has a global-instruction surface. A skill trigger is the floor on every harness. This repo stays the single source. Paths must not name one agent's home directory. Delivery stays in 000-dotfiles. Standing-rule injection for Claude stays. Add Grok home rules and Gemini/Agy global instructions. Hermes, Pi, and Codex get the portable skill now; standing-rule files wait until that CLI is present. README must stop saying Claude-only and stop teaching a one-agent symlink as the supported install. State that the checker is a denylist, not Issue 9 conformance. Relabel the experiment table. Recurring-errors file is a reference list. Out of scope: Issue 9 dictionary, new experiment scorer, rewriting 001 in place."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - The rule is on without a flag on every wired harness (Priority: P1)

The owner starts a session on a harness that already has a global-instruction surface. The owner types no flag and does not invoke the skill. The session names ASD-STE100 as the writing standard.

This holds for Claude Code (already wired), Grok Build, and Antigravity. It does not yet hold for Hermes, Pi, or Codex, because those harnesses have no recorded global-instruction dest.

**Why this priority**: A rule that needs a remembered flag has failed. This is the same requirement as the first feature, now across harnesses.

**Independent Test**: Start a fresh session on each wired harness with no extra argument. Ask which writing standard the instructions impose. Each must name ASD-STE100.

**Acceptance Scenarios**:

1. **Given** the work is complete, **When** the owner starts Claude Code with no extra argument, **Then** the session names ASD-STE100.
2. **Given** the work is complete, **When** the owner starts Grok Build with no extra argument, **Then** the session names ASD-STE100.
3. **Given** the work is complete, **When** the owner starts Antigravity with no extra argument, **Then** the session names ASD-STE100.
4. **Given** the work is complete, **When** the owner starts Claude Code the way they already do (plain command, gateway command, or offload), **Then** the session still names ASD-STE100. This is a regression check.

---

### User Story 2 - The skill is on every harness (Priority: P1)

The owner invokes the writing skill, or a task matches its description. The skill loads on each of the six harnesses that `000-dotfiles` delivers skills to, when that CLI is installed.

**Why this priority**: Skill load is the floor. A harness with no standing-rule dest still has the skill.

**Independent Test**: On each installed CLI, confirm the skill directory is present at that harness's skill dest, and that a task that matches the skill description can load it.

**Acceptance Scenarios**:

1. **Given** any of the six CLIs is installed, **When** `000-dotfiles` apply has run, **Then** the portable skill copy exists and that CLI can load `ste-writing`.
2. **Given** Claude Code is installed, **When** apply has run, **Then** the Claude vendor copy of the skill exists as well as the portable copy.
3. **Given** Antigravity is installed, **When** apply has run, **Then** the Antigravity vendor copy of the skill exists as well as the portable copy.
4. **Given** Hermes is installed, **When** apply has run, **Then** the Hermes vendor copy of the skill exists as well as the portable copy.
5. **Given** a CLI is not installed, **When** apply has run, **Then** that CLI's vendor copy is not required, and no test claims that CLI ran.

---

### User Story 3 - Paths and install steps name no single agent (Priority: P2)

A reader of the skill, the five-line rule, or the README can follow them on any of the six harnesses. No file tells the reader to look only under one agent's home directory. The supported install is the machine setup command in `000-dotfiles`, not a one-agent symlink.

**Why this priority**: Hard-coded paths make the standing rule and the checker fail on every harness except one.

**Independent Test**: Search the skill, the five-line rule, the README, and the senior-engineer prompt for a single-agent home path. The search must find none. Follow the README install section. It names `000-dotfiles` apply as the supported path.

**Acceptance Scenarios**:

1. **Given** a clean read of the skill, the five-line rule, the README, and the senior-engineer prompt, **When** a reader looks for a home path that names one agent, **Then** they find none.
2. **Given** the README install section, **When** a reader follows it on this owner's machine, **Then** the steps run `000-dotfiles` apply or sync, not a one-agent symlink as the supported path.
3. **Given** the checker command in the skill, **When** the agent runs it, **Then** the command is `uv run ste-lint.py` next to the skill file the agent loaded.

---

### User Story 4 - Claims match what the checker can do (Priority: P2)

A reader who has not seen the standard learns what the checker is. The text says it is an anti-slop denylist. It does not say a lint pass is Issue 9 conformance. The experiment table says it measured checker-compliance with one run per cell. The recurring-errors file is a reference list, not linter input.

**Why this priority**: The repo's own constitution forbids a dictionary claim the checker cannot keep.

**Independent Test**: Read the README, the skill, the experiment summary, and the licence notice. Confirm each claim in this story. Run the documented checker command on the README.

**Acceptance Scenarios**:

1. **Given** the README and the skill, **When** a reader looks for a conformance claim, **Then** they find a denylist statement and no claim that a lint pass is Issue 9 conformance.
2. **Given** the experiment summary, **When** a reader looks at the headline table, **Then** the table is labelled as checker-compliance, one generation per cell, and not as reader comprehension.
3. **Given** the licence or the recurring-errors file, **When** a reader looks at how the file is used, **Then** the text says it is a reference list, not linter input.
4. **Given** the README, **When** a reader runs the documented checker command, **Then** the command runs on this machine.

---

### Edge Cases

- A CLI in the six is not installed. Apply skips that vendor dest. Tests do not claim that CLI ran.
- Hermes, Pi, or Codex is installed later. The portable skill copy MUST already be the dest those CLIs scan. A standing-rule file for that CLI is a later change, after the dest is recorded.
- The owner supplies a competing system-prompt argument to the Claude gateway. The wrapper still steps aside. That behaviour is unchanged.
- The five-line rule file is renamed or missing. Claude still starts (existing fail-open). Grok and Antigravity still start. The skill remains invocable.
- A stranger clones this repo without `000-dotfiles`. Authoring still works. The README MUST NOT present that clone as the supported standing-rule install.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The writing rule MUST be active in a fresh session, with no extra argument and no skill invoke, on every harness that this feature wires a global-instruction surface for: Claude Code, Grok Build, and Antigravity.
- **FR-002**: Claude Code's existing standing-rule routes MUST keep working.
- **FR-003**: The skill MUST be delivered to the portable skill dest when any of the six CLIs is installed, and to the vendor dest for Claude Code, Hermes, and Antigravity when that CLI is installed.
- **FR-004**: This repository MUST remain the single source of the skill, the checker, the five-line rule, and the senior-engineer prompt.
- **FR-005**: The skill, the five-line rule, the README, and the senior-engineer prompt MUST NOT hard-code a home path that names one agent.
- **FR-006**: The checker command in the skill MUST be `uv run ste-lint.py` relative to the skill file the agent loaded.
- **FR-007**: Supported install on this owner's machines MUST be `000-dotfiles` apply or sync.
- **FR-008**: The README MUST NOT teach a one-agent symlink as the supported install.
- **FR-009**: The README and the skill MUST state that the checker is an anti-slop denylist and that a lint pass is not Issue 9 conformance.
- **FR-010**: The experiment summary MUST label its table as checker-compliance with one generation per cell. It MUST NOT present that table as a comprehension study.
- **FR-011**: The recurring-errors file MUST be described as a reference list, not as linter input.
- **FR-012**: Delivery of copies to agent dests MUST stay in `000-dotfiles`. This repo MUST NOT add per-agent skill trees for delivery.
- **FR-013**: Hermes, Pi, and Codex MUST receive the portable skill copy through `000-dotfiles`. This feature MUST NOT invent a standing-rule dest for those three.
- **FR-014**: A success report MUST NOT claim a runtime test on a CLI that is not on the machine.
- **FR-015**: `001-ste-standing-rule` MUST NOT be rewritten in place.

### Key Entities

- **The five-line rule**: Names the standard, the skill, and the checker. One copy in this repo. Injected into each wired global-instruction surface.
- **The skill**: The ruleset a session loads when a task matches, or when the owner invokes it.
- **The checker**: The denylist script that counts violations per 100 words. It does not load the Issue 9 dictionary.
- **The harness set**: Claude Code, Grok Build, Antigravity, Hermes, Pi, Codex. The first three get standing-rule wiring in this feature. All six get the skill floor when installed.
- **Delivery**: The `000-dotfiles` apply path that copies the skill and writes standing-rule files.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Three of three wired harnesses (Claude Code, Grok Build, Antigravity) name ASD-STE100 in a fresh session with no extra argument and no skill invoke.
- **SC-002**: Claude Code still names ASD-STE100 on the routes that already worked (plain command, gateway command, gateway offload).
- **SC-003**: After apply, the portable skill copy exists. The Claude vendor copy exists. The Antigravity vendor copy exists. A search of the skill, the five-line rule, the README, and the senior-engineer prompt finds no home path that names one agent.
- **SC-004**: A reader following the README install section is told to run `000-dotfiles` apply or sync. The documented checker command runs on this machine. The README still scores under 2.5 violations per 100 words on the shipped checker.
- **SC-005**: The README and the skill each contain an explicit denylist / non-conformance statement. The experiment summary labels the table as checker-compliance, one generation per cell. The recurring-errors description does not call the file linter input.

## Assumptions

- The six CLIs are the set `000-dotfiles` already uses for skill delivery. This feature does not add a seventh harness.
- On this machine, Claude Code, Grok Build, and Antigravity are installed. Hermes, Pi, and Codex are not. Runtime checks cover the first three only.
- Grok Build reads home rules from its user rules directory, and reads portable skills from the agents skill dest (and may also see the Claude vendor dest through compatibility). Antigravity reads its global instruction file and its vendor skill dest.
- Claude Code's SessionStart hook and gateway append stay the standing-rule mechanism for Claude. This feature does not replace them.
- `000-dotfiles` already copies a `kind: skill` tree to the portable dest and to Claude/Hermes/Antigravity vendor dests. This feature may need to fix apply so those dests actually exist after apply, and to add standing-rule files for Grok and Antigravity.
- Loading the Issue 9 dictionary and running a new experiment are later features.
- The project constitution v1.0.0 is in force.
