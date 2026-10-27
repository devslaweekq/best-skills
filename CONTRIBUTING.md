# Contributing

Thanks for helping improve best-skills, a Claude Code plugin marketplace with skills and commands. The repository structure and the file
formats are described in [README.md](README.md); this page covers what to check before sending a change.

## Priorities

- **Small and focused.** A skill or command does one job. If it needs a long preamble to explain what it is for, split it or cut it.
- **Repository-agnostic.** Skills and commands must not mention a specific company, project, ticket prefix, team member, internal
  repository or PR number. Whatever is specific to a codebase is discovered at run time from that codebase's own docs and config.
- **Accurate triggers.** A skill's `description` states only when it should load ("Use when..."), in the third person. It is not a summary
  of what the skill does.
- **Honest behavior.** Commands that change things outside the working tree (create a PR, post a comment, push) ask for explicit
  confirmation first.
- **English only** for everything in the repository: skills, commands, docs, commit messages.

## Before you open an issue or a pull request

- Check that the issue or pull request doesn't already exist.
- For a new skill or command, open an issue first to agree on the scope, unless it is a small, obvious addition.
- Imported third-party content stays near-verbatim and must be listed in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) together with its
  license. Don't import anything whose license doesn't allow redistribution.

## Checklist for a skill or command

- [ ] Skill: `plugins/devslaweekq/skills/<kebab-case-name>/SKILL.md` with `name` and `description` in the frontmatter. No `$ARGUMENTS`.
- [ ] Command: `plugins/devslaweekq/commands/<name>.md` with `description` (and `argument-hint` if it takes input). `$ARGUMENTS` is allowed.
- [ ] Helper files (templates, references, scripts) live next to the skill that uses them.
- [ ] No project-specific names, ticket keys, reviewers, URLs or credentials. Quick check:
      `grep -rniE "<company>|<project>|<ticket-prefix>" .`
- [ ] The README table lists the new skill or command.
- [ ] Try it: install the plugin from your branch and invoke the skill or command in a real session.

## Style

- Follow `.editorconfig`: UTF-8, 2-space indentation, LF line endings, a final newline, lines up to 120 characters (Markdown is exempt).
- Keep wording direct and concrete. No filler, no marketing language.
- Commit messages use `feat:` / `fix:` / `chore:` / `docs:`, one line, under 100 characters.

## Versioning and releases

Claude Code caches a plugin by the version in `plugins/devslaweekq/.claude-plugin/plugin.json`, so any change under `plugins/devslaweekq/`
needs a version bump to reach users. Maintainers do that with `scripts/release.sh` (see "Versioning and release" in the README). Don't edit
the version by hand in a pull request.

Changes that touch only `README.md`, `CONTRIBUTING.md` or `CLAUDE.md` don't need a release.
