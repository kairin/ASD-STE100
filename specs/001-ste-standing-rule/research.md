# Research: how to place a standing rule in every session

Phase 0 output. Documentation answered none of these three questions, so we
measured each one. No question stays open.

---

## 1. Does the settings key place text in the system prompt?

**Decision**: No. Do not use `appendSystemPrompt` in user settings.

**Rationale**: We measured this. We added the key to `~/.claude/settings.json`
with `jq` and gave it a unique marker. A throwaway sink captured one request
body.

The marker did not appear in the body at all. The `system` field held 3 blocks
of about 10,000 characters, so the request was correct and the field was full.
The key simply did nothing.

We then restored the settings file. It matched its backup byte for byte, and all
six guard-hook groups survived.

The release contains the key once, in the fragment
`["managedSettings","appendSystemPrompt"]`. That agrees with the measurement.
The agent reads this key from managed settings, not from user settings.

**Alternatives considered**: We rejected asking a session "do you see the
marker?". A session reports presence, not placement, because the agent also
injects instruction-file content. Only the wire separates the two.

---

## 2. Where does the agent instruction file arrive?

**Decision**: It arrives in the messages, not in the system prompt. Use it
anyway, as the second route.

**Rationale**: The same capture shows content from `~/.claude/CLAUDE.md` in the
`messages` field, marked as a `claudeMd` reminder. The `system` field does not
hold it. The owner was right: the instruction file is not the system prompt.

It stays necessary. It is the only route that reaches every launcher. It is also
the only route that reaches task-tool subagents, and this owner writes much of
his prose there.

**Alternatives considered**: We rejected dropping it and keeping only the
argument. That breaks FR-004. The plain command, the editor, scripts, and every
subagent would then carry no rule.

---

## 3. Can an argument reach subagents?

**Decision**: No, not in an interactive session. Two routes exist for this
reason.

**Rationale**: `--append-subagent-system-prompt` exists. Its description ends
"(only works with `--print`)". It has no file variant. So no argument reaches a
subagent in an interactive session.

The main argument carries no such limit. Its description ends at "append to the
default system prompt" and stops there. It applies to interactive sessions. The
release marks it hide-help, which is why `--help` omits it.

**Alternatives considered**: We rejected running everything headless to gain the
subagent argument. That changes how the owner works to suit a mechanism, which
inverts the requirement.

---

## What this means for the design

- Two routes. Neither one covers the other's gap.
- A later release can remove the argument. The design prefers a loud stop. The
  wrapper passes the argument always, so a removal fails at once with a clear
  message instead of dropping the rule in silence.
- The rule text lives once, in this repo. Both routes point at that copy. Two
  copies would drift apart.
- Renaming the rule file turns the argument off and leaves the wrapper working.
  That is the kill switch. It needs no edit.
