# Provider purge record

This record supports ASD-STE100 issues #9 and #12.
It records each deleted path and its disposition.

## Scope

The purge removes content for tools outside the approved delivery set.
It also removes machine-specific generated state.
The approved tools are Hermes, Pi, OpenAI Codex CLI, and Google Antigravity (`agy`).

The five payload files stay in the repository.
Issue #10 controls their content and delivery checks.

## Issue #12 review

Issue #12 reviewed the current 20-path purge snapshot. The retained files are
active documentation. They define the current writing rules and delivery
scope.

- `.specify/memory/constitution.md`
- `AGENTS.md`
- `ste-senior-engineer-prompt.md`
- `ste-writing-skill.md`

The three experiment and sample files below are historical evidence. They
describe retired provider comparisons. The 13 files below `specs/` are
obsolete specifications. They describe shipped or replaced work. The current
source files define the supported payload. This record gives the deletion
provenance.

The review found no secret values or owner-specific paths in the retained
active documentation. The repository keeps the deleted-path lists below as
the deletion provenance.

## Deleted experiment files

Disposition: dispose.

The files contained provider-dependent results and examples.
The repository does not claim that these results apply to the approved tools.
The README keeps the tool-neutral explanation of the writing method.

- `before-after-samples.md`
- `experiment-results-openai.md`
- `experiment-results.md`

## Deleted shipped specifications

Disposition: dispose.

These specifications describe completed or replaced delivery designs.
The current source files and delivery map now define the behavior.

- `specs/001-ste-standing-rule/checklists/requirements.md`
- `specs/001-ste-standing-rule/plan.md`
- `specs/001-ste-standing-rule/quickstart.md`
- `specs/001-ste-standing-rule/research.md`
- `specs/001-ste-standing-rule/spec.md`
- `specs/001-ste-standing-rule/tasks.md`
- `specs/002-multi-agent-ste/checklists/requirements.md`
- `specs/002-multi-agent-ste/data-model.md`
- `specs/002-multi-agent-ste/plan.md`
- `specs/002-multi-agent-ste/quickstart.md`
- `specs/002-multi-agent-ste/research.md`
- `specs/002-multi-agent-ste/spec.md`
- `specs/002-multi-agent-ste/tasks.md`

## Deleted generated adapter files

Disposition: dispose.

These files were generated for a tool outside the approved delivery set.
The generic Spec Kit scripts and templates remain in `.specify/`.

- `.grok/skills/speckit-analyze/SKILL.md`
- `.grok/skills/speckit-checklist/SKILL.md`
- `.grok/skills/speckit-clarify/SKILL.md`
- `.grok/skills/speckit-constitution/SKILL.md`
- `.grok/skills/speckit-converge/SKILL.md`
- `.grok/skills/speckit-implement/SKILL.md`
- `.grok/skills/speckit-plan/SKILL.md`
- `.grok/skills/speckit-specify/SKILL.md`
- `.grok/skills/speckit-tasks/SKILL.md`
- `.grok/skills/speckit-taskstoissues/SKILL.md`

## Deleted machine state

Disposition: dispose.

These files selected one local integration or one deleted feature directory.
They do not define reusable repository behavior.

- `.specify/feature.json`
- `.specify/init-options.json`
- `.specify/integration.json`
- `.specify/integrations/grok.manifest.json`

## Retained content

The repository retains the generic Spec Kit scaffold.
The workflow now uses its initialized integration without provider examples.
The delivery documentation names tools only where a destination differs.

## Acceptance evidence

Use these checks before parent review:

1. Search the current tree for removed-provider names.
2. Compare the five payload hashes with the pre-purge hashes.
3. Run the payload checker during issue #10.
4. Run `git diff --check`.

Historical Git objects and hosted metadata are outside this candidate patch.
