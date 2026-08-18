# ASD-STE100 writing skill for Claude Code

A Claude Code skill that rewrites prose (docs, READMEs, PR descriptions, error
messages, release notes, comments, tool descriptions, system prompts — never
code) into ASD-STE100 Simplified Technical English, to remove "AI slop".

This repo is a personal install of the `ste-writing` skill and its supporting
files, published from the source referenced below.

## References

- Video: [The Cure for AI Slop](https://www.youtube.com/watch?v=uJblcC4lKYw&t=9s)
- Source: [woosal1337/blog — videos/ep01-the-cure-for-ai-slop](https://github.com/woosal1337/blog/tree/main/videos/ep01-the-cure-for-ai-slop)

## Contents

| File | Purpose |
|---|---|
| `ste-writing-skill.md` | The skill definition (rules, modes, guards) |
| `ste-recurring-errors.md` | ASD-STE100's own list of the 39 most common writer errors |
| `ste-lint.py` | Heuristic anti-slop linter used to score drafts |
| `run-openai.py` | Script used to reproduce the cross-model experiment on OpenAI models |
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
python3 ste-lint.py draft.md            # flavored target: under 2.5 per 100 words
python3 ste-lint.py --strict draft.md   # strict target: under 1.5 per 100 words
```

## Global enforcement (fish + system prompt)

The skill only fires when Claude Code judges a task matches its description.
To make ASD-STE100 the default for every response in every session, this
setup adds a standing instruction ahead of the skill, using two files outside
this repo:

1. **`~/.config/fish/functions/claude.fish`** — a fish wrapper function that
   intercepts the `claude` command and appends a system-prompt file to every
   invocation:

   ```fish
   function claude --wraps claude
       command claude --append-system-prompt-file ~/.claude/system-append.md $argv
   end
   ```

2. **`~/.claude/system-append.md`** — the file the wrapper appends. Its first
   rule tells every session to write prose in ASD-STE100 and to use this
   skill as the mechanism:

   ```
   1. LANGUAGE: Output tokens are precious. Write all prose in ASD-STE100
      Simplified Technical English. Use the installed `ste-writing` skill
      (`~/.claude/skills/ste-writing/`) to apply the rules and check drafts
      with `ste-lint.py`.
   ```

Together, this means: the fish function guarantees the rule loads into the
system prompt of every `claude` session, and the rule points at the skill
installed from this repo (see [Install](#install)) as the ruleset and linter
to use. The skill's own trigger (task-matched auto-invoke or `/ste-writing`)
still applies on top of this for a full rewrite/review pass.

## Notes

This is an unofficial, personal skill and is not affiliated with ASD. The
full ASD-STE100 standard is free at https://asd-ste100.org. ASD-STE100 is a
registered EU trademark (No. 017966390).
