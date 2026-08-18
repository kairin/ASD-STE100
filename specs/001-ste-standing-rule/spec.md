# Feature Specification: ASD-STE100 standing writing rule

**Feature Branch**: `001-ste-standing-rule`

**Created**: 2026-08-18

**Status**: Draft (revision 2)

**Input**: User description: make ASD-STE100 the standing writing rule for every
Claude Code session on this machine, and fill out the repo content from its
source video. The owner must never type a flag to get the rule.

**Revision 2 replaces FR-012 and SC-003.** Revision 1 said the gateway wrapper
must never change. The owner asked why the wrapper could not carry the routing
and the rule together. It can. The wrapper is 56 lines of shell that end in one
command line. A flag there gives system-prompt placement and changes no routing
variable.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - The rule applies with no flag to remember (Priority: P1)

The owner starts a session and types no flag. The session writes prose in
ASD-STE100. This holds for the gateway route and for the plain route.

**Why this priority**: This is the requirement in the owner's own words. A rule
that needs a remembered flag has failed, however strong its placement.

**Independent Test**: Type the gateway command with no arguments. Type the plain
command with no arguments. Ask each which writing standard it must obey.

**Acceptance Scenarios**:

1. **Given** the work is complete, **When** the owner types the gateway command
   with no arguments, **Then** the session names ASD-STE100, and the rule is in
   the system prompt.
2. **Given** the work is complete, **When** the owner types the plain command
   with no arguments, **Then** the session names ASD-STE100.
3. **Given** the work is complete, **When** the owner adds the offload argument,
   **Then** the session names ASD-STE100 and uses the offload models.
4. **Given** a session supplies its own system-prompt argument, **When** it
   starts through the gateway, **Then** the wrapper steps aside and the session
   starts. It does not fail.

---

### User Story 2 - The rule reaches subagents (Priority: P2)

A task-tool subagent writes prose. The prose obeys ASD-STE100.

**Why this priority**: The owner runs many subagents, so much of the prose he
keeps comes from them. No flag can reach a subagent in an interactive session,
so a second route is necessary.

**Independent Test**: Start one trivial subagent. Ask it which writing standard
its instructions impose.

**Acceptance Scenarios**:

1. **Given** the work is complete, **When** a subagent starts, **Then** it names
   ASD-STE100.
2. **Given** the rule file is renamed, **When** a subagent starts, **Then** it
   still names ASD-STE100, because the second route does not depend on that file.

---

### User Story 3 - The owner can see whether the rule is on (Priority: P2)

The owner asks the wrapper for its state. The wrapper answers and stops. It does
not start a session.

**Why this priority**: The wiring is invisible. A silent downgrade would look
the same as correct operation.

**Acceptance Scenarios**:

1. **Given** the check argument, **When** the owner runs the wrapper, **Then** it
   reports whether the rule file resolves, which mode would run, and which
   address it would use, and then exits.
2. **Given** the rule file is renamed, **When** the owner runs the check,
   **Then** the report says the file does not resolve.

---

### User Story 4 - The skill teaches categories, not word lists (Priority: P3)

A session removes slop that the skill never listed, because it holds a rule for
the category.

**Why this priority**: The repo's own measurement gives a word list about 3
percent and a full system 74 percent. A skill built from word lists repeats the
fault it exists to correct.

**Acceptance Scenarios**:

1. **Given** prose with a marketing word absent from the skill, **When** a
   session rewrites it, **Then** the word is gone.
2. **Given** the skill and the checker, **When** a reader compares them, **Then**
   no checker category lacks a rule in the skill.

---

### User Story 5 - The repo explains itself and is honest (Priority: P3)

A reader who has not seen the source video learns why the standard works and
what the repo can do.

**Acceptance Scenarios**:

1. **Given** a clean copy, **When** a reader follows the install steps, **Then**
   every command runs on this machine.
2. **Given** the README, **When** a reader looks for the reason, **Then** they
   find the origin, the habit-to-rule map, and the evidence.
3. **Given** the repo, **When** a reader looks for licence terms, **Then** they
   find them.

### Edge Cases

- The rule file is absent. The wrapper omits the argument and the session still
  starts. The rule still applies through the second route.
- A later release removes the argument. Gateway sessions fail at once with a
  clear message. This is intended: a loud stop is better than a silent loss.
- The caller supplies a competing system-prompt argument. The wrapper steps
  aside, because the two cannot both apply.
- The wrapper runs with no arguments at all. The argument list must stay safe
  when empty. The script stops on unset variables.
- The skill and the checker disagree on sentence length. The repo's headline
  number was measured with the stricter of the two.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The rule MUST be active in every session, whatever the launcher,
  including task-tool subagents.
- **FR-002**: The owner MUST NOT have to type any argument to get the rule. The
  gateway command with no arguments, and the plain command with no arguments,
  both apply it.
- **FR-003**: Gateway sessions MUST carry the rule in the system prompt.
- **FR-004**: A second route MUST carry the rule for the plain command, the
  editor, scripts, and subagents.
- **FR-005**: The rule MUST name the skill as the ruleset and the checker as the
  verifier.
- **FR-006**: The skill MUST be reachable at the path the agent loads skills
  from, under the filename that agent expects.
- **FR-007**: The wrapper MUST offer a check mode that reports the rule file's
  state, the mode that would run, and the address that would be used, then exits
  without starting a session.
- **FR-008**: Renaming the rule file MUST disable the injection and return the
  wrapper to its earlier behaviour, with no edit to the script.
- **FR-009**: The wrapper MUST step aside when the caller supplies a competing
  system-prompt argument, instead of failing.
- **FR-010**: The skill MUST state a rule for each of the six measured slop
  habits as a category, not only as examples.
- **FR-011**: Every checker category MUST have a matching rule in the skill.
- **FR-012 (NON-NEGOTIABLE, REVISED)**: Only the final command line of the
  gateway wrapper may change. Every routing variable it sets MUST survive
  unchanged, in both of its modes.
- **FR-013 (NON-NEGOTIABLE)**: No credential, address, or model variable MUST be
  added to the agent's environment settings.
- **FR-014 (NON-NEGOTIABLE)**: The model setting MUST NOT change.
- **FR-015 (NON-NEGOTIABLE)**: The agent command path MUST NOT be wrapped or
  replaced. An update repoints it.
- **FR-016 (NON-NEGOTIABLE)**: The workspace instruction files MUST stay
  symbolic links to their shared target.
- **FR-017 (NON-NEGOTIABLE)**: Settings changes MUST be made with a tool that
  validates the format, and MUST be checked after the change. That file holds
  the guard hooks, and a format error can remove them without a message.
- **FR-018**: The skill and the checker MUST agree on the sentence-length limit,
  or the difference MUST be recorded where a reader will see it.
- **FR-019**: The README MUST give the origin, the map from slop habit to rule,
  and the measured evidence. It MUST NOT describe a mechanism that cannot work.
- **FR-020**: Documented checker commands MUST run on this machine.
- **FR-021**: Files that cannot run MUST be removed, or marked as unable to run.
- **FR-022**: Text taken from other authors MUST carry licence terms.

### Key Entities

- **The rule**: about five lines. Names the standard, the skill, and the checker.
  One copy, referenced from two places.
- **The skill**: the ruleset a session loads when a task matches it.
- **The checker**: the script that counts violations for each 100 words.
- **The gateway wrapper**: the route from the agent to the local model gateway.
  It now also carries the rule.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Four of four routes report the rule: the plain command, the
  gateway command, the gateway command in offload mode, and a subagent.
- **SC-002**: The gateway answers one prompt in each of its two modes, and its
  restart count does not climb.
- **SC-003 (REVISED)**: The live and tracked copies of the wrapper match each
  other, the script passes a syntax check, and both address exports survive.
- **SC-004**: The settings file keeps all six guard-hook groups after the work.
- **SC-005**: The owner types zero arguments in two of the three routes, and one
  pre-existing argument in the third.
- **SC-006**: The check mode reports the correct state in both cases: rule file
  present, and rule file renamed.
- **SC-007**: The repo README scores below 2.5 violations for each 100 words.
- **SC-008**: Each of the six slop habits has a category rule in the skill, and
  the skill stays below 115 lines.
- **SC-009**: Every command in the README runs on this machine.

## Assumptions

- The two routes are complementary, not alternatives. The argument gives
  system-prompt placement but cannot reach subagents in an interactive session.
  The instruction file reaches every launcher but is not the system prompt.
- The settings key for an appended system prompt is not honored from user
  settings. A capture of one request showed the marker absent from the body
  while the system field held three blocks of about ten thousand characters.
- The argument the wrapper passes is hidden from the help output. This is a
  property of the release, not an error. A later release may remove it, and the
  design prefers a loud stop to a silent loss.
- The offload argument stays as it is. It predates this work, it is occasional,
  and it selects a different billing route.
- The plain command keeps its present behaviour and does not use the gateway.
  This split is deliberate and is reviewed after a week of use.
- The project constitution is still an unfilled template, so no project
  principle constrains this work.
- Durable machine settings are mirrored to the machine's configuration repo,
  which is the record for this machine.
