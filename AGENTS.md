# AGENTS.md

## Repo Scope

- This repository is a yadm-managed Ubuntu dotfiles repo with the work tree rooted at `/home/seterlet`.
- Prefer `yadm` over `git` for status, diff, add, and tracked-file queries.
- Limit exploration to tracked files. Do not infer behavior from other untracked files in the home directory.
- The main automation lives in [.config/yadm/bootstrap](.config/yadm/bootstrap) and [.config/yadm/bootstrap.d](.config/yadm/bootstrap.d).

## Vagrant Sandbox

- This repo also includes a Vagrant and VirtualBox sandbox rooted at [Vagrantfile](Vagrantfile).
- Treat host-side Vagrant files as VM configuration; most sandbox experiments should run inside the guest.
- Repo-local VS Code chat settings auto-approve the Vagrant-related terminal commands configured in [.vscode/settings.json](.vscode/settings.json).

## Vagrant Workflow

- Check machine state with `vagrant status` before guest work.
- Start every new chat session with a named snapshot via `vagrant snapshot save NAME` before the first guest command. Use a unique descriptive name such as `session-YYYYMMDD-HHMMSS`.
- Run guest commands through `vagrant ssh -c "..."`; add `sudo` inside the quoted command when root is required.
- Do not use raw `ssh`; this sandbox relies on Vagrant-managed SSH settings.
- After editing [Vagrantfile](Vagrantfile), run `vagrant validate` before any other VM action.

## Vagrant Safety

- After the session-start snapshot, create another named snapshot before especially risky guest changes.
- If an experiment goes badly, recover with `vagrant snapshot restore NAME`.
- Prefer named snapshots (`save` and `restore`) and do not mix them with `push` and `pop`.
- Do not halt, suspend, reboot, destroy, or otherwise change VM power state without explicit user approval.
- `vagrant ssh -c` runs inside a transient shell; background jobs will terminate unless they are explicitly detached.

## Bootstrap Workflow

- [.config/yadm/bootstrap](.config/yadm/bootstrap) is the entrypoint. It finds executable files in `.config/yadm/bootstrap.d`, sorts them lexically, and stops on the first failure.
- Add new automation as numbered executable Bash scripts under [.config/yadm/bootstrap.d](.config/yadm/bootstrap.d) so ordering stays explicit.
- Match the existing script style: `#!/usr/bin/env bash` plus `set -euo pipefail`.
- Keep scripts idempotent. Bootstrap is expected to be safe to rerun on the same machine.
- Avoid interactive prompts inside bootstrap scripts. If a task cannot be automated, add or update the manual checklist in [.config/yadm/bootstrap.d/99-checklist](.config/yadm/bootstrap.d/99-checklist).
- Use opt-in environment flags for preference changes. Mirror switching already follows this pattern in [.config/yadm/bootstrap.d/01-apt-mirror](.config/yadm/bootstrap.d/01-apt-mirror) via `USE_FAST_MIRROR=1`.

## Validation

- There is no application build or test suite. For bootstrap changes, validate with `bash -n` on touched scripts and review idempotency carefully.
- Do not run `yadm bootstrap` unless the user explicitly wants system-level changes executed.
- Treat edits as high impact: scripts install packages, add apt repositories, edit PAM configuration, and change global Git settings. 

## Key References

- Fresh-machine setup and transcrypt flow: [Documents/init.md](Documents/init.md)
- Bootstrap dispatcher: [.config/yadm/bootstrap](.config/yadm/bootstrap)
- Manual post-bootstrap steps: [.config/yadm/bootstrap.d/99-checklist](.config/yadm/bootstrap.d/99-checklist)
- Base package install: [.config/yadm/bootstrap.d/05-base-packages](.config/yadm/bootstrap.d/05-base-packages)
- Microsoft repository setup: [.config/yadm/bootstrap.d/10-microsoft-keys-and-repos](.config/yadm/bootstrap.d/10-microsoft-keys-and-repos)
- Microsoft package install: [.config/yadm/bootstrap.d/20-microsoft-packages](.config/yadm/bootstrap.d/20-microsoft-packages)
- Git and Git Credential Manager setup: [.config/yadm/bootstrap.d/50-git-and-gcm](.config/yadm/bootstrap.d/50-git-and-gcm)
- Node and npm bootstrap: [.config/yadm/bootstrap.d/70-nvm-and-node](.config/yadm/bootstrap.d/70-nvm-and-node)
- .NET and NuGet bootstrap: [.config/yadm/bootstrap.d/80-dotnet-and-nuget](.config/yadm/bootstrap.d/80-dotnet-and-nuget)

## Change Guidance

- Keep repository-source setup separate from package installation, following the existing split between the `10-*` and `20-*` scripts.
- Preserve the numbered-step structure instead of folding multiple concerns into one script.
- Ask before changing user-specific values such as Git identity, Microsoft account assumptions, tenant-specific URLs, or package feed endpoints.
- When bootstrap behavior changes, update the most relevant script comment or the checklist instead of duplicating detailed docs in this file.