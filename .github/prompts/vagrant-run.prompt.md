---
name: vagrant-run
description: Run a one-off command inside this repository's Vagrant guest using the safe command pattern.
argument-hint: "guest command to run"
agent: agent
---

Use this prompt to run a one-off command inside the guest VM for this repository.

Before acting, read [AGENTS.md](../../AGENTS.md) and inspect [Vagrantfile](../../Vagrantfile) if the request depends on VM configuration.

Follow this procedure:

1. Run `vagrant status` first.
2. If the VM is not running, stop and explain that you need explicit user approval before changing VM power state.
3. At the start of a new chat session, create a named snapshot with `vagrant snapshot save NAME` before the first guest command. Use a unique descriptive name such as `session-YYYYMMDD-HHMMSS`.
4. Run the guest command through `vagrant ssh -c "..."`.
5. Add `sudo` inside the quoted guest command only when the task requires elevated privileges.
6. If the request is especially risky, create an additional named snapshot first with `vagrant snapshot save NAME`.
7. Use named snapshots only. Do not use `push` or `pop`.
8. Do not use raw `ssh`.
9. Do not halt, suspend, reboot, reload, or destroy the VM without explicit user approval.
10. If the user wants a background process, explain that `vagrant ssh -c` runs in a transient shell and background jobs terminate unless explicitly detached.
11. Report the exact host-side Vagrant command you ran and summarize the important guest output.

Treat package installation, system configuration changes, service management, kernel changes, and filesystem-destructive operations as risky.

If the requested command is missing or ambiguous, ask one concise clarifying question before running anything.