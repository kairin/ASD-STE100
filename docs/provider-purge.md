# Provider purge record

This record supports ASD-STE100 issue #9.
It records each deleted path and its disposition.

## Scope

The purge removes content for tools outside the approved delivery set.
It also removes machine-specific generated state.
The approved tools are Hermes, Pi, OpenAI Codex CLI, and Google Antigravity (`agy`).

The five payload files stay in the repository.
Issue #10 controls their content and delivery checks.

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
