# ASD-STE100 writing skill for Claude Code

A Claude Code skill that rewrites prose (docs, READMEs, PR descriptions, error
messages, release notes, comments, tool descriptions, system prompts — never
code) into ASD-STE100 Simplified Technical English, to remove "AI slop".

This repo holds the `ste-writing` skill and its supporting files. It follows
the method shown in the video and source repo below.

## References

- Video: [The Cure for AI Slop](https://www.youtube.com/watch?v=uJblcC4lKYw&t=9s)
- Source: [woosal1337/blog — videos/ep01-the-cure-for-ai-slop](https://github.com/woosal1337/blog/tree/main/videos/ep01-the-cure-for-ai-slop)

## Why this works

ASD-STE100 began in 1986. European aircraft makers needed maintenance
manuals that any mechanic could read, including readers whose first
language was not English.

The standard rests on two pillars. The first is procedural rules: one
instruction per sentence, active voice, no semicolons. The second is a
controlled dictionary of about 900 approved words, each word with one
meaning.

Six writing habits create most AI slop. Each habit has a matching rule:

| Habit | Rule |
|---|---|
| Synonym rotation | 1.11, one name for one thing |
| Hedging stacks | 3.4, no stacked auxiliaries |
| Nominalization | 3.7, use a verb for an action |
| Marketing adjectives | the controlled dictionary |
| Run-on sentences | 5.1 and 6.3, the length caps |
| Phrasal verbs | 9.3, no phrasal verbs |

A 1996 study found ASD-STE100 raised reader comprehension. The score went
from 76% to 86% for all readers, and from 69% to 87% for readers whose
first language was not English. A 2007 Microsoft Research study ran 520
sentences through 4 languages. The largest single gain came from removing
flowery, indirect text.

This repo's own experiment (see [experiment-results.md](experiment-results.md))
found a 74% cut in slop on Claude sonnet. The checker used a 20-word cap
for that count. ASD-STE100 itself allows 25 words for descriptive
sentences, so the checker is stricter than the standard.

One caution: oversimplified text can slow reading for an expert reader
who already knows the subject. STE trades some of that speed for a wider
group of readers who can read the text without error.

## Contents

| File | Purpose |
|---|---|
| `ste-writing-skill.md` | The skill definition (rules, modes, guards) |
| `ste-recurring-errors.md` | ASD-STE100's own list of the 39 most common writer errors |
| `ste-lint.py` | Heuristic anti-slop linter used to score drafts |
| `experiment-results.md` | Cross-model experiment summary (Claude vs GPT) |
| `experiment-results-openai.md` | Per-category experiment results, OpenAI side |
| `before-after-samples.md` | Real before/after output samples |

## Install

Clone this repo, then symlink the skill into Claude Code's skills directory:

```bash
git clone https://github.com/kairin/ASD-STE100.git ~/Apps/ASD-STE100
cd ~/Apps/ASD-STE100

mkdir -p ~/.claude/skills/ste-writing
ln -s "$PWD/ste-writing-skill.md" ~/.claude/skills/ste-writing/SKILL.md
ln -s "$PWD/ste-lint.py" "$PWD/ste-recurring-errors.md" ~/.claude/skills/ste-writing/
```

If this repo is already checked out locally (for example at
`~/Apps/ASD-STE100`), skip the `git clone` step and just `cd` into it before
running the `mkdir`/`ln` commands above.

Verify the install:

```bash
ls -la ~/.claude/skills/ste-writing/
```

You should see `SKILL.md`, `ste-lint.py`, and `ste-recurring-errors.md` as
symlinks pointing back into this repo.

## Use

Once installed, Claude Code picks up the skill automatically when a task
matches its description (rewriting docs, READMEs, PR text, error messages,
etc.), or invoke it directly with `/ste-writing`.

To lint a draft manually:

```bash
uv run ste-lint.py draft.md            # flavored target: under 2.5 per 100 words
uv run ste-lint.py --strict draft.md   # strict target: under 1.5 per 100 words
```

## Standing rule outside the skill trigger

The skill fires only when Claude Code judges a task matches its description.
This setup also feeds the rule through two routes outside that trigger.

1. **Gateway sessions.** The `claude-gw` wrapper (a separate dotfiles repo)
   passes `--append-system-prompt-file` with `ste-system-append.md`, unless
   the caller sets one already.
2. **Every other route.** A plain `claude` command, an editor, a script, or
   a subagent reads the rule from `~/.claude/CLAUDE.md`, which Claude Code
   loads every session.

A fish function can wrap only the `claude` command it defines. It cannot
reach a session an editor, a script, or a subagent starts through a
different launcher. `~/.claude/CLAUDE.md` can, because Claude Code reads
that file on every session, not only ones a fish function starts.

## Notes

This is an unofficial, personal skill and is not affiliated with ASD. The
full ASD-STE100 standard is free at https://asd-ste100.org. ASD-STE100 is a
registered EU trademark (No. 017966390).
