# Validation guide

Phase 1 output. One section for each success criterion in
[spec.md](./spec.md). Run all of them before any commit. Every command is
read-only unless marked otherwise.

## Prerequisites

- The gateway unit is active before you start. Record its restart count now, so
  SC-002 has a baseline:
  ```bash
  systemctl --user is-active llm-gateway
  systemctl --user show llm-gateway -p NRestarts
  ```
- `~/.claude/settings.json` is backed up.
- `~/.claude/CLAUDE.md` is backed up.

---

## SC-001: four routes report the rule

```bash
claude              -p 'One line: what writing standard do your instructions impose?'
claude-gw           -p 'One line: what writing standard do your instructions impose?'
claude-gw --offload -p 'One line: what writing standard do your instructions impose?'
```

Each must name ASD-STE100. For the fourth route, start one trivial task
subagent and ask it the same question. It must also name ASD-STE100. This is the
route no argument can reach, so it is the one most worth checking.

## SC-002: the gateway still answers, and does not restart

The three commands above already sent one prompt through each mode. Then:

```bash
journalctl --user -u llm-gateway -n 20 --no-pager | grep '\[llm-gateway\]'
systemctl --user show llm-gateway -p NRestarts
```

Expect one line for each request, and a restart count equal to the baseline.

## SC-003: the wrapper is sound and its routing survives

```bash
diff ~/.local/bin/claude-gw ~/Apps/000-dotfiles/local-bin/claude-gw && echo IN-SYNC
bash -n ~/.local/bin/claude-gw && echo PARSES
grep -c 'export ANTHROPIC_BASE_URL' ~/.local/bin/claude-gw     # expect 2
grep -c 'export ANTHROPIC_AUTH_TOKEN' ~/.local/bin/claude-gw   # expect 1
```

All four must pass. The last two prove the routing exports survived the edit,
which is the whole risk of touching this file.

## SC-004: the guard hooks survived

```bash
jq '.hooks.PreToolUse | length' ~/.claude/settings.json        # expect 6
jq -r '.env | keys[]' ~/.claude/settings.json | grep -i anthropic && echo FAIL || echo OK
jq -r '.model' ~/.claude/settings.json                         # unchanged
```

## SC-005: the owner types no argument

Not a command. Read the three lines under SC-001. Two carry no argument. The
third carries `--offload`, which predates this work. No argument in any of them
concerns the writing rule.

## SC-006: check mode reports both states

```bash
claude-gw --check                       # must report the file resolves
claude-gw --offload --check             # must report offload mode and its address

mv ~/.claude/ste-system-append.md{,.off}
claude-gw --check                       # must report the file does NOT resolve
claude-gw -p 'reply OK'                 # must still start and answer
mv ~/.claude/ste-system-append.md{.off,}
claude-gw --check                       # must report it resolves again
```

This block is not read-only: it renames a file twice and restores it. It proves
the kill switch works and, more importantly, that a missing rule file does not
break the wrapper.

## SC-007: the README scores under 2.5

```bash
cd ~/Apps/ASD-STE100 && uv run ste-lint.py README.md
```

Never `python3`. A guard hook denies it.

## SC-008: the skill covers six habits and stays short

```bash
wc -l ste-writing-skill.md              # under 115
```

Then read the skill once and confirm each of the six habits has a rule stated as
a category: synonym rotation, hedging, nominalization, marketing adjectives,
run-on sentences, phrasal verbs. Confirm no checker category lacks a rule.

## SC-009: every README command runs

Copy each command block out of the README and run it. Any command that fails is
a defect in the README, not in the machine.

---

## If something fails

Fastest partial rollback, no edit needed:

```bash
mv ~/.claude/ste-system-append.md{,.off}
```

The wrapper then omits the argument and behaves exactly as it did before this
feature. Full rollback is in the repo plan.
