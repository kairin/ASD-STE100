# Hermes cost-aware orchestration

Status: proposed implementation contract

This document describes routing for Hermes, Pi harness, OpenAI Codex, and Google Antigravity (`agy`). It does not configure a provider or enable a model by itself.

## Hermes profile naming

Use numbered Hermes profiles (`profile_1`, `profile_2`, `profile_3`, …), not role names such as `asdcheap` or `asdpremium`. Roles are declared in the task contract and verified from live configuration. The current intended mapping is `profile_2` for architect-only GPT-6 Astra, `profile_1` for the non-Spark orchestration candidate, and `profile_3` reserved for a future leaf route.

## Hard model rule

**GPT Codex Spark is opt-in only.** It must not be selected by a default profile, alias, delegation setting, Kanban setting, auxiliary model, or generated configuration. Use it only when the owner manually enables it for a specific run or profile and verifies the effective model.

The current default route remains the approved non-Spark route. A cheaper model may become the orchestrator only after it passes the orchestration capability probe.

## Three roles

| Role | Responsibility | Model policy |
|---|---|---|
| Architect | Architecture, decisions, decomposition, acceptance tests | GPT-6 Astra only when explicitly assigned |
| Orchestrator | Claims tasks, assigns workers, tracks outputs, retries, synthesizes | Lowest-cost model that passes the probe |
| Worker | One bounded research, coding, test, or documentation task | Cheapest suitable model or deterministic script |

The architect does not perform grind work and does not fan out workers. The orchestrator does not silently promote work to the architect tier.

## Durable workflow

Use Hermes Kanban for work that must survive a session. Use GitHub Issues for durable work identity and a GitHub Project for the Kanban view. Use `delegate_task` only for bounded work inside one session.

```text
triage → architect review → approved task graph → ready tasks
→ worker claims → evidence → verification → review → completion
```

Every task must have an ID, parent, dependencies, type, scope, owner, model, tier, allowed writes, expected output, acceptance test, retry limit, and evidence requirement.

## Output contract

Workers return:

```text
STATUS: COMPLETE | INCOMPLETE
TASK_ID: ...
SCOPE: ...
COMPLETED: ...
UNFINISHED: ...
FINDINGS: ...
EVIDENCE: ...
FILES_CHANGED: ...
TESTS_RUN: ...
BLOCKER: ...
NEEDS: ...
```

A worker's prose claim does not complete a task without evidence. External writes require read-back verification.

## Retry policy

Retry a failed task twice at its original tier. Narrow the task when the scope is too large. Escalate only after the retry limit and record both failures. Do not promote the complete graph because one shard failed.

## Required preflight

Before dispatching a graph, inspect the effective live state:

```text
hermes config get model
hermes config get delegation
hermes config get kanban
hermes config get auxiliary.kanban_decomposer
hermes config get auxiliary.triage_specifier
```

Confirm:

- Spark is not selected unless manually enabled.
- The Kanban orchestrator is not the GPT-6 architect profile.
- Every task has an explicit model or deterministic runner.
- Leaf workers cannot spawn children.
- The task list and dependencies exist before dispatch.

## Capability probe

Before approving a mid-tier orchestrator, run a non-destructive test with two independent leaf tasks. The candidate must preserve dependencies, assign explicit leaf tiers, track child IDs, retry one failed child without promotion, and synthesize only after evidence is present. Approve the cheapest candidate that passes.

## Supported tool set

The generic policy source is `AGENTS.md` plus portable skills. Native adapter files are permitted only for:

- Hermes
- Pi harness
- OpenAI Codex
- Google Antigravity (`agy`)

No Claude-specific or Grok-specific configuration is part of this plan.
