---
name: vagrantfile-edit
description: Make a requested change to the Vagrantfile, validate it, and avoid unapproved VM state changes.
argument-hint: "requested Vagrantfile change"
agent: agent
---

Use this prompt when the task is to change this repository's [Vagrantfile](../../Vagrantfile).

Before editing, read [AGENTS.md](../../AGENTS.md) and the current [Vagrantfile](../../Vagrantfile).

Follow this procedure:

1. Keep the change focused on the requested Vagrantfile behavior.
2. Preserve the existing style and provider-specific tuning unless the request requires a change.
3. If the change affects SSH access, remember that this repo intentionally uses Vagrant-managed SSH instead of raw `ssh`.
4. After every Vagrantfile edit, run `vagrant validate` before any other VM action.
5. If validation fails, fix the file if the issue is clearly caused by your edit; otherwise stop and report the failure.
6. Do not run `vagrant up`, `vagrant halt`, `vagrant suspend`, `vagrant reload`, `vagrant destroy`, or any guest reboot command without explicit user approval.
7. If the requested change would make later guest experiments risky, suggest taking a named snapshot before those experiments.
8. Summarize the file change and the validation result.

Do not perform unrelated guest changes as part of this prompt.