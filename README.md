# ASD-STE100 writing skill

A skill that rewrites prose (docs, READMEs, PR descriptions, error
messages, release notes, comments, tool descriptions, system prompts — never
code) into ASD-STE100 Simplified Technical English, to remove "AI slop".

This repo holds the `ste-writing` skill and its supporting files. It follows
the method shown in the video and source repo below.

The skill is for Claude Code, Grok Build, Antigravity, Hermes, Pi, and Codex.
`000-dotfiles` installs those six CLIs as baseline tools and copies the skill
to each one.

## References

- Video: [The Cure for AI Slop](https://www.youtube.com/watch?v=uJblcC4lKYw&t=9s)
- Source: [woosal1337/blog — videos/ep01-the-cure-for-ai-slop](https://github.com/woosal1337/blog/tree/main/videos/ep01-the-cure-for-ai-slop)
- Video: [FIXING Opus 5](https://www.youtube.com/watch?v=S_QdQ1G4GlU), IndyDevDan. Source of the operational-boundary rules in the unified prompt.

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

The experiment in this repo (see [experiment-results.md](experiment-results.md))
measured checker-compliance, not reader comprehension. On Claude sonnet the
checker score fell 74 percent. The checker used a 20-word cap for that
count. ASD-STE100 itself allows 25 words for descriptive sentences, so the
checker is stricter than the standard.

The checker is an anti-slop denylist. A lint pass is not ASD-STE100 Issue 9
conformance. The checker does not load the approved dictionary.

One caution: oversimplified text can slow reading for an expert reader
who already knows the subject. STE trades some of that speed for a wider
group of readers who can read the text without error.

## Contents

| File | Purpose |
|---|---|
| `ste-writing-skill.md` | The skill definition (rules, modes, guards) |
| `ste-senior-engineer-prompt.md` | Unified senior-engineer + ASD-STE100 system prompt |
| `ste-recurring-errors.md` | Reference list of the 39 most common writer errors in ASD-STE100 |
| `ste-lint.py` | Heuristic anti-slop denylist used to score drafts |
| `experiment-results.md` | Cross-model checker-compliance summary (Claude vs GPT) |
| `experiment-results-openai.md` | Per-category checker results, OpenAI side |
| `before-after-samples.md` | Real before/after output samples |
| `AGENTS.md` | Five-line standing rule for harnesses that read that file |

## Install

This repo is the source of the skill, the checker, and the five-line rule.
Author content here.

On this owner machine, the supported install is the `000-dotfiles` setup
command. Option 1 installs the six coding-agent CLIs with each vendor's
official curl script. Apply then copies the skill to those CLIs:

```bash
~/Apps/000-dotfiles/setup apply
```

`setup sync --yes` does the same apply step after it updates the machine
profile. After apply, run the checker from this repo:

```bash
cd ~/Apps/ASD-STE100
uv run ste-lint.py README.md
```

To refresh the copies that `000-dotfiles` vendors from this repo, run
`~/Apps/000-dotfiles/scripts/sync-ste-writing.sh`, then apply again.

A clone of this repo without `000-dotfiles` is for authoring. It is not the
supported standing-rule install.

## Use

Once delivered, the agent loads the skill when a task matches its
description (rewriting docs, READMEs, PR text, error messages), or when
you invoke `/ste-writing`.

To lint a draft from this repo:

```bash
uv run ste-lint.py draft.md            # flavored target: under 2.5 per 100 words
uv run ste-lint.py --strict draft.md   # strict target: under 1.5 per 100 words
```

Run the same command next to the skill file the agent loaded.

## Standing rule outside the skill trigger

The skill fires only when the agent judges a task matches its description.
`000-dotfiles` also injects the five-line rule through each harness that has
a global-instruction surface.

1. **Claude Code.** A SessionStart hook injects the five-line rule at the
   start of every session. The `claude-gw` wrapper also appends that rule
   unless the caller already set a system prompt.
2. **Grok Build.** The same five-line rule is a user home rule, so a fresh
   session loads it with no extra argument.
3. **Antigravity.** The global instruction file points at the skill and the
   five-line rule.

Hermes, Pi, and Codex get the skill (portable dest, plus the Hermes vendor
dest). They do not yet get a standing-rule file. Do not invent a dest.

The ops note in `000-dotfiles` records how to check the dests.

## Unified senior-engineer prompt

`ste-senior-engineer-prompt.md` is one system prompt. It merges the language
rules of ASD-STE100 with the operational rules from the "Senior Opus" method
by IndyDevDan. Those operational rules include scope containment,
evidence-based completion, clean artifacts, reference codes, and the four
aliases.

Pass the file with the agent system-prompt flag, or copy the content into
the system-prompt field of a tool. If you pass that flag to `claude-gw`, the
wrapper skips its default five-line append.

The file must stay clean under its own check. Run
`uv run ste-lint.py --strict ste-senior-engineer-prompt.md`. The score must
be under 1.5 per 100 words.

Lint score v3 added the vocabulary of the prompt to the checker. The checker
now knows the `delve` family, `tapestry`, `loadbearing`, `load-bearing`,
`the honest truth`, the `streamline` family, two hedge phrases, and the
`look into` family. The em-dash count now skips code blocks and inline
code. The experiment numbers predate score v3. The version notes in
`ste-lint.py` record the history.

The clean-artifacts rule of the prompt bans co-author tags in commits. A
repo that keeps co-author trailers can remove the co-author words from that
bullet. The watermark ban and the metadata ban then stay.

## Notes

This is an unofficial, personal skill and is not affiliated with ASD. The
full ASD-STE100 standard is free at https://asd-ste100.org. ASD-STE100 is a
registered EU trademark (No. 017966390).
