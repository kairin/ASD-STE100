# ASD-STE100 agent guidelines

1. LANGUAGE: Write all prose in ASD-STE100 Simplified Technical English.
2. Use the `ste-writing` skill for the rules.
3. Check each draft with `uv run ste-lint.py <file>` next to the skill file.
4. SCOPE: This rule applies to prose. It does not apply to code, identifiers, or command syntax.
5. SCOPE: This rule also applies to comments made in code.

The checker is an anti-slop denylist. A lint pass is not Issue 9 conformance.

Source files live in this repository. A downstream delivery repository copies
the skill to Hermes, Pi, OpenAI Codex CLI, and Google Antigravity (`agy`).
