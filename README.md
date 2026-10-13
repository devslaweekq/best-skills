# best-skills

A shared library of Claude Code skills and commands by devslaweekq, distributed as a plugin marketplace.

## What's included

| Type    | Name              | Purpose                                                                                   |
| ------- | ----------------- | ----------------------------------------------------------------------------------------- |
| Skill   | `frontend-design` | Guidance for distinctive, intentional visual design when building or reshaping UI         |
| Skill   | `human-comments`  | Rules for writing short, human-sounding comments and replies for colleagues               |
| Command | `/create-pr`      | Create a GitHub PR for the current branch, filling the repository's PR template concisely |
| Command | `/pre-pr`         | Self-review the current branch against the repository's own rules before opening a PR     |
| Command | `/review-replies` | Triage unresolved PR review threads, draft replies and optionally apply the fixes         |
| Command | `/human`          | Rewrite a draft or write a reply following the `human-comments` rules                     |
| Command | `/parallel`       | Split a task into independent parts and run them with parallel agents                     |

The commands are repository-agnostic: they read the conventions (PR template, contributing docs, CODEOWNERS, lint and test commands) from
the repository they are run in.

## Repository structure

```
best-skills/
├── .claude-plugin/
│   └── marketplace.json        # marketplace catalog (don't change its name or location)
├── plugins/
│   └── devslaweekq/
│       ├── .claude-plugin/
│       │   └── plugin.json     # plugin metadata and version
│       ├── skills/
│       │   └── <skill-name>/
│       │       └── SKILL.md    # auto skill: Claude loads it by its description
│       └── commands/
│           └── <command-name>.md  # manual command: invoked as /command-name
└── scripts/
    └── release.sh              # version bump, commit, tag and push
```

**Skills vs commands: don't mix them up.**

- `skills/<name>/SKILL.md`: Claude decides on its own whether to load a skill, based on the `description` field in the frontmatter. Required
  fields: `name` (kebab-case) and `description` (third person, starts with "Use when...", describes only the trigger conditions). Arguments
  are not supported, so `$ARGUMENTS` doesn't work here.
- `commands/<name>.md`: invoked manually as `/<name> arguments`. Frontmatter: `description`, optionally `argument-hint`. The body can use
  `$ARGUMENTS`, which is replaced with whatever follows the command name.

## Adding a new skill

Create `plugins/devslaweekq/skills/<skill-name>/SKILL.md`:

```markdown
---
name: skill-name
description: Use when ... (third person, trigger conditions only)
---

# Skill Name

Skill content.
```

If a skill needs helper files (templates, references, scripts), put them next to it in the same skill folder (for example `references/` or
`scripts/`).

## Adding a new command

Create `plugins/devslaweekq/commands/<command-name>.md`:

```markdown
---
description: What the command does
argument-hint: [param]
---

Command body. $ARGUMENTS
```

Keep skills and commands free of project-specific details (ticket prefixes, team member names, internal repository names, PR numbers).
Anything specific to one codebase should be discovered at run time from that codebase's own docs and configuration.

## Installation

Anyone using Claude Code runs the following (interactive slash commands):

1. Add the marketplace once:

```
/plugin marketplace add devslaweekq/best-skills
```

2. Install the plugin:

```
/plugin install devslaweekq@devslaweekq-skills
```

3. Update after changes land in the repository:

```
/plugin marketplace update devslaweekq-skills
```

This adds the `devslaweekq-skills` marketplace and installs the `devslaweekq` plugin (skills `frontend-design` and `human-comments`, plus
the commands `/create-pr`, `/parallel`, `/pre-pr`, `/review-replies` and `/human`).

Check what is installed:

```
/plugin list
```

To have the marketplace connect automatically for everyone who clones a project (without a manual `/plugin marketplace add`), add this once
to `.claude/settings.json` of the target project (not this repository, but the repository where the team works):

```json
{
    "extraKnownMarketplaces": {
        "devslaweekq-skills": {
            "source": { "source": "github", "repo": "devslaweekq/best-skills" },
            "autoUpdate": true
        }
    }
}
```

Once the project folder is trusted (trust prompt), the marketplace is fetched automatically. Each person still runs the install, or you can
pin the plugin through `enabledPlugins` in the same `settings.json`.

## Versioning and release

Claude Code shows in `/plugin list` the version from the explicit `"version"` field of `plugins/devslaweekq/.claude-plugin/plugin.json`. If
that field doesn't change, the short hash of the current commit on the `main` branch is shown instead; a git tag has no effect on that. That
is why the version must be bumped in that field on every release, not just tagged.

`scripts/release.sh` does this: it bumps the version in `plugin.json`, commits, tags, and pushes the commit and the tag to `origin`:

```bash
scripts/release.sh "commit message"              # patch release: 1.0.1 -> 1.0.2
scripts/release.sh "commit message" minor        # 1.0.1 -> 1.1.0
scripts/release.sh "commit message" major        # 1.0.1 -> 2.0.0
```

Before running it, make sure every change that should go into the release is in the working directory (the script runs `git add -A`). The
script needs `node` and a configured `origin` remote. After the push, users pick up the new version with:

```
/plugin marketplace update devslaweekq-skills
/reload-plugins
/plugin list
```
