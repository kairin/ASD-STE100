# Validation guide

Phase 1 output. One section per success criterion in [spec.md](./spec.md). Run these after both repos have landed and `000-dotfiles` apply has run. Runtime checks cover Claude Code, Grok Build, and Antigravity only.

## Prerequisites

```bash
command -v claude; command -v grok; command -v agy
command -v hermes || echo 'hermes not installed (expected)'
command -v pi || echo 'pi not installed (expected)'
command -v codex || echo 'codex not installed (expected)'
```

---

## SC-001: three wired harnesses name the rule

Fresh sessions. No extra argument. No skill invoke.

```bash
claude -p 'One line: what writing standard do your instructions impose?'
```

Start a new Grok session in this repo and ask the same question. Start a new Antigravity (`agy`) session and ask the same question.

Each answer must name ASD-STE100.

---

## SC-002: Claude routes still work

```bash
claude -p 'One line: what writing standard do your instructions impose?'
claude-gw -p 'One line: what writing standard do your instructions impose?'
claude-gw --offload -p 'One line: what writing standard do your instructions impose?'
```

Each must name ASD-STE100.

---

## SC-003: dests exist and content has no one-agent home path

```bash
test -f "$HOME/.agents/skills/ste-writing/SKILL.md" && echo portable-ok
test -f "$HOME/.claude/skills/ste-writing/SKILL.md" && echo claude-vendor-ok
test -f "$HOME/.gemini/config/skills/ste-writing/SKILL.md" && echo agy-vendor-ok
test -f "$HOME/.grok/rules/ste-writing.md" && echo grok-rule-ok
rg -n '\$HOME/\.claude/|~/.claude/|~/.grok/|~/.hermes/|~/.gemini/|~/.agents/' \
  ste-system-append.md ste-writing-skill.md ste-senior-engineer-prompt.md README.md \
  && echo FAIL || echo no-one-agent-home-path
```

Expect the four `test` lines to print ok. Expect `no-one-agent-home-path`.

---

## SC-004: README install and checker

Read the README install section. It must name `000-dotfiles` apply or sync as the supported path. It must not present `ln -s` into one agent's skills directory as the supported path.

```bash
cd ~/Apps/ASD-STE100 && uv run ste-lint.py README.md
```

Expect `per100w` under 2.5. Never `python3`.

---

## SC-005: honesty statements

Read README, `ste-writing-skill.md`, `experiment-results.md`, and `LICENSE`.

- README and skill: denylist, not Issue 9 conformance.
- Experiment table: checker-compliance, one generation per cell.
- Recurring-errors: reference list, not linter input.

---

## If something fails

Claude kill switch, unchanged:

```bash
mv ~/.claude/ste-system-append.md{,.off}
```

Grok: remove or rename `~/.grok/rules/ste-writing.md`. Antigravity: revert the pointer in `~/.gemini/GEMINI.md` from the `000-dotfiles` backup.
