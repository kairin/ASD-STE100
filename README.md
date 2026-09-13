# ASD-STE100 writing skill

A skill that rewrites prose (docs, READMEs, PR descriptions, error
messages, release notes, comments, tool descriptions, system prompts. Never
code) into ASD-STE100 Simplified Technical English, to remove "AI slop".

This repository holds the `ste-writing` skill and its supporting files.
It follows the method shown in the video and source repository below.

The skill is for Hermes, Pi, OpenAI Codex CLI, and Google Antigravity (`agy`).
The delivery map is in [docs/ste-delivery.md](docs/ste-delivery.md).
The downstream delivery work is tracked in
[ASD-STE100 issue #10](https://github.com/kairin/ASD-STE100/issues/10).

## Workspace layout

This repository must live at `~/Apps/ASD-STE100`. Two sibling clones must also exist:

- `~/Apps/000-dotfiles`
- `~/Apps/tmux-cheat-sheet`

If `000-dotfiles` is present, run `~/Apps/000-dotfiles/scripts/ensure-workspace-layout.sh`.
That command creates `~/Apps/AGENTS.md` and `~/Apps/GEMINI.md`
as symlinks to `~/Apps/000-dotfiles/AGENTS.md`.

## References

- Video: [The Cure for AI Slop](https://www.youtube.com/watch?v=uJblcC4lKYw&t=9s)
- Source: [woosal1337/blog, videos/ep01-the-cure-for-ai-slop](https://github.com/woosal1337/blog/tree/main/videos/ep01-the-cure-for-ai-slop)

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

`ste-lint.py` is a denylist check, not full Issue 9 conformance. It does not
load the approved dictionary.

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
| `docs/ste-delivery.md` | Canonical payload and destination map |
| `scripts/check-ste-payload.sh` | Local source, package, destination, and purge checks |
| `AGENTS.md` | Five-line standing rule for harnesses that read that file |

## Install

This repository is the source of the five-file payload. Author content here.

The supported delivery path is the downstream setup command. It copies the
automated package to the destinations in [docs/ste-delivery.md](docs/ste-delivery.md):

```bash
setup apply
```

After delivery, run the checker from this repository:

```bash
uv run ste-lint.py README.md
```

The downstream repository owns packaging and installation. This repository
does not write files in an agent home directory.

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

The skill fires when a task matches its description. The downstream delivery
system copies the three-file skill package to supported skill directories.
The standing rule file remains manual.

1. **Hermes.** The package uses the portable and Hermes vendor destinations.
2. **Pi.** The package uses the portable destination.
3. **OpenAI Codex CLI.** The package uses the portable destination.
4. **Google Antigravity (`agy`).** The package uses the portable and vendor
   destinations.

The complete file map is in [docs/ste-delivery.md](docs/ste-delivery.md).

## Unified senior-engineer prompt

`ste-senior-engineer-prompt.md` is one system prompt. It merges the language
rules of ASD-STE100 with operational rules for scope containment,
evidence-based completion, clean artifacts, reference codes, and four aliases.

Pass the file with the agent system-prompt option, or copy its content into
the system-prompt field of a tool.

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
