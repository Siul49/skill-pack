# skill-pack

Reusable Codex skill bundle for projects using `.agent` workflows.

## Contents
- `.agent/skills/*`
- `.agent/workflows/*`
- `.agent/config/user-preferences.yaml`
- `.agent/mcp.json`

## Included Automation Packs
- `project-customizer`: generate project-specific `verify-*` skill from config and sync routing/registries.
- `project-fit-orchestrator`: run multiple `verify-*` skills in parallel from one command.
- `ensure-big-task-docs`: enforce plan/context/checklist loop for large tasks.

## Install into a project
```powershell
powershell -ExecutionPolicy Bypass -File scripts/install-to-project.ps1 -TargetPath "C:\path\to\project" -ApplyLocalIgnore -SetSkipWorktree
```

## One-line update (pull latest + install)
```powershell
powershell -ExecutionPolicy Bypass -File scripts/sync-project.ps1 -TargetPath "C:\path\to\project" -ApplyLocalIgnore -SetSkipWorktree
```

## What install script does
1. Copies `.agent` assets into target project (excluding `.agent/reports`, `.agent/plan.json`).
2. Adds local-only ignore rules into `.git/info/exclude` (including `.agent/`).
3. Optionally sets `skip-worktree` for tracked `.agent/*` files to reduce local noise.

## Notes
- `.git/info/exclude` is local-only and is not committed.
- `skip-worktree` is local-only git index behavior.
- To undo skip-worktree:
```powershell
git -C <project> ls-files .agent | ForEach-Object { git -C <project> update-index --no-skip-worktree -- $_ }
```
