# Codex Agent Policy

This repository enforces skill-first execution for every user turn.

## Mandatory Turn-Start Skill Resolution

1. For every user message, resolve related skills before any tool use or code edit.
2. Priority order:
   - Explicitly named skills in the user message
   - Keyword routing from `.agent/skills/_shared/skill-routing.md`
   - Best fallback skill when no direct match exists
3. Announce selected skills in one short line before execution.
   - Format: `사용 스킬: <skill1>, <skill2> (reason)`
4. If no skill matches, state fallback clearly and continue.
5. Do not skip this process, even for short requests.

## Routing Source of Truth

- Primary routing map: `.agent/skills/_shared/skill-routing.md`
- Verification orchestration: `.agent/skills/verify-implementation/SKILL.md`
- Skill maintenance and sync: `.agent/skills/manage-skills/SKILL.md`

## Mandatory Big-Task Documentation Loop

For every large task, create and maintain this 3-document pack:

1. plan document
2. context document
3. checklist document

### Start of Big Task (Required)

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .agent/skills/_shared/ensure-big-task-docs.ps1 -Workspace . -Mode Init -TaskId <task-id>
```

This creates:
- `.agent/context/<task-id>/plan.md`
- `.agent/context/<task-id>/context.md`
- `.agent/context/<task-id>/checklist.md`

### Before Every Subtask (Required)

Read the 3 documents, then record review checkpoint:

```powershell
powershell -ExecutionPolicy Bypass -File .agent/skills/_shared/ensure-big-task-docs.ps1 -Workspace . -Mode Review -TaskId <task-id> -SubtaskNote "<subtask summary>"
```

### Enforcement

`preflight.ps1` runs a big-task docs guard (`Mode Check`) and blocks execution if docs are missing or stale.

## Update Rule

When adding/updating/removing verify skills, synchronize:

1. `.agent/skills/manage-skills/SKILL.md`
2. `.agent/skills/verify-implementation/SKILL.md`
3. `.agent/skills/_shared/skill-routing.md`

Then run:

```powershell
powershell -ExecutionPolicy Bypass -File .agent/skills/manage-skills/scripts/validate-skill-links.ps1
powershell -ExecutionPolicy Bypass -File .agent/skills/manage-skills/scripts/validate-verify-registry.ps1 -RepoRoot .
```
