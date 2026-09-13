<!--
Sync Impact Report
- Version change: unfilled template → 1.0.0 (first ratification)
- Modified principles: [PRINCIPLE_1_NAME] → I. Prose Rule; [PRINCIPLE_2_NAME] → II. Denylist Checker; [PRINCIPLE_3_NAME] → III. One Content Repo; [PRINCIPLE_4_NAME] → IV. Standing Rule; [PRINCIPLE_5_NAME] → V. Speckit Authors Specs
- Added sections: Delivery Constraints; Development Workflow
- Removed sections: none (placeholders replaced)
- Follow-up TODOs: none
-->
# ASD-STE100 Constitution

## Core Principles

### I. Prose Rule
ASD-STE100 applies to prose: documentation, comments, pull-request text, error messages, release notes, tool descriptions, system prompts, and agent-to-agent messages. It MUST NOT apply to code, identifiers, or command syntax. A change that rewrites an identifier to satisfy a writing rule is a constitution violation.

### II. Denylist Checker
`ste-lint.py` is an anti-slop denylist. A lint pass is NOT Issue 9 conformance. The skill, README, and checker output MUST NOT claim the Issue 9 dictionary (875 approved words, 1274 unapproved words) unless the checker loads that dictionary. The 20-word checker cap MAY be stricter than rule 6.3. That gap MUST be stated where a reader will see it.

### III. One Content Repo
This repository is the single source of the skill, the checker, the five-line rule, and the senior-engineer prompt. A downstream delivery repository delivers those files to Hermes, Pi, OpenAI Codex CLI, and Google Antigravity (`agy`). Skill files, the five-line rule, and README install steps MUST NOT hard-code one agent's home path. The checker command is `uv run ste-lint.py` next to the skill file the agent loaded.

### IV. Standing Rule
Where a harness has a global-instruction surface that `000-dotfiles` can manage, the five-line rule MUST be injected there. The owner MUST NOT have to type a flag or invoke `/ste-writing` to get the rule on that harness. Skill auto-invoke is the floor on every harness. It is NOT a substitute for a global-instruction surface. A runtime test MUST NOT be claimed for a CLI that is not on the machine.

### V. Speckit Authors Specs
`spec.md`, `plan.md`, `tasks.md`, and `.specify/memory/constitution.md` MUST be written only by the `/speckit-*` commands installed in this project. Hand-authoring one of those files when a command exists for that step is a constitution violation.

## Delivery Constraints

Supported install for this owner's machines is `000-dotfiles` `./setup apply` (or `sync`). A `ln -s` into one agent's skills directory is not the supported path. Manual clone of this repo is for authoring.

`ste-recurring-errors.md` is a reference list. It is not linter input unless the checker reads that file.

Text taken from other authors MUST carry licence terms. This repo MUST NOT paste ASD-STE100 in full. ASD-STE100 is a registered EU trademark (No. 017966390). This repo is unofficial.

## Development Workflow

Python in this repo runs through `uv`. Bare `python` / `pip` is forbidden for project work.

Never commit or push without an explicit instruction. Never commit directly to `main`. Use a `YYYYMMDD-HHMMSS` branch, then a pull request.

A success criterion that names a checker score MUST be reproducible with the shipped `ste-lint.py` and the stated score version. An experiment table MUST say what it measured. It MUST NOT present checker-compliance as reader comprehension.

## Governance

This constitution supersedes skill text, README claims, and feature specs when they conflict. A spec that requires a dictionary claim the checker cannot keep MUST be rejected or the checker MUST load the dictionary in the same change.

Amendments: run `/speckit-constitution` with the new principle or the change. Bump **Version** (MAJOR for a removed or redefined principle, MINOR for a new principle, PATCH for a clarification). Set **Last Amended** to the amendment date. Record the change in the Sync Impact Report comment at the top of this file.

Compliance: `/speckit-plan` and `/speckit-analyze` MUST load this file. A PR that changes the skill, the checker, the five-line rule, or the README MUST not introduce a path, install step, or dictionary claim that violates I–IV.

**Version**: 1.0.0 | **Ratified**: 2026-09-06 | **Last Amended**: 2026-09-06
