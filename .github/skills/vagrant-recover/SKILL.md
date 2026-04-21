---
name: vagrant-recover
description: Inspect Vagrant VM state, list or create named snapshots, and restore a named snapshot for this repository when the VM experiment needs recovery.
argument-hint: "symptom or snapshot name"
disable-model-invocation: true
---

# Vagrant Recovery

Use this skill when the VM has drifted into a bad state, when an experiment might need rollback, or when the user asks to inspect or restore snapshots.

Start by reading [AGENTS.md](../../../AGENTS.md) and [Vagrantfile](../../../Vagrantfile).

## Recovery Rules

1. Check `vagrant status` before deciding on any recovery step.
2. At the start of a new chat session, create a named snapshot with `vagrant snapshot save NAME` before new debugging work when the current VM state still allows it. Use a unique descriptive name such as `session-YYYYMMDD-HHMMSS`.
3. For inspection, prefer non-destructive commands first: `vagrant snapshot list` and targeted `vagrant ssh -c "..."` checks.
4. Before a risky new debugging attempt, create an additional named snapshot with `vagrant snapshot save NAME`.
5. To roll back, restore a named snapshot with `vagrant snapshot restore NAME`.
6. Use named snapshots only. Do not mix `save` and `restore` with `push` and `pop`.
7. Do not halt, suspend, reboot, reload, or destroy the VM without explicit user approval.
8. If the VM is not running and recovery would require a power-state change, stop and ask for approval instead of guessing.
9. When restoring, confirm or infer the exact snapshot name from `vagrant snapshot list` and report what will be restored before running the command.
10. After any snapshot operation, re-run `vagrant status` and summarize the resulting machine state.

## Examples

- Inspect available recovery points: `vagrant snapshot list`
- Create a rollback point before a risky change: `vagrant snapshot save before-package-upgrade`
- Restore a known-safe point: `vagrant snapshot restore before-package-upgrade`

If the user only describes a symptom and does not ask for restoration yet, inspect first and recommend the safest next step.