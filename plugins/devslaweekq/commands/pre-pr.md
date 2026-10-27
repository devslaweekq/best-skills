---
description: Self-review the current branch against the repository's own review rules before opening a PR (report only, no edits)
argument-hint: [run]
---

Review the current branch before a PR, using the repository's own rules. Report only: don't edit anything, commit or push. The word `run` in
$ARGUMENTS enables step 5 (lint, tests, build).

**Step 1. Diff.** Determine the base branch (the default branch, or the integration branch named in the contributing docs). Then
`git fetch origin <base>`, `git diff --name-status origin/<base>...HEAD` and `git log --oneline origin/<base>..HEAD`. Work out which
packages, apps or modules are touched. Read the diff itself, not just the file names.

**Step 2. Rules.** Find the repository's own review rules and read them in full, authoritative sources first: `CONTRIBUTING.md`, `CLAUDE.md`
/ `AGENTS.md`, `.claude/`, `.cursor/rules/`, `docs/` guidelines, the PR template, linter and formatter configs. If the diff contains tests,
also read the testing guidelines if there are any. Check against those files, not from memory. If the repository has no written rules at
all, say so and limit the review to the generic checks in step 3.

**Step 3. Checks on the diff.** Look only at lines the diff adds. Old violations in the same files don't count (fixing them would widen the
scope). Cover at least:

- **Configuration.** Every new environment variable or config key is declared everywhere the repository declares them (env examples, CI and
  test env files, config schema, docs).
- **Async code.** Unbounded parallelism over large collections, missing `await`, swallowed errors.
- **Tests.** Behavior is covered, including negative cases; no `.only` / `.skip` left in; snapshots are committed; the repository's test
  structure and naming conventions are followed.
- **Layers and architecture.** Responsibilities sit where the repository puts them (controllers, services, repositories, validation,
  logging), and the repository's own decorators and helpers are used instead of ad-hoc ones.
- **Style.** File and symbol naming, import order, comments, language of messages and logs, no `console.log` and no commented-out code, no
  unrelated changes (reformatting, other people's files).
- **Migrations.** File and class naming, a working rollback, schema consistent with the entities.
- **Branch and commits.** Branch name and commit messages follow the repository's convention (check the contributing docs and recent
  history); the branch is not behind the base branch.

Check every explicit rule from the repository's guidelines separately.

**Step 4. Report.** Three groups:

1. **Blocks the PR.** Violations a reviewer would send the PR back for.
2. **Worth fixing.** Likely review comments.
3. **Checked, clean.** One line on what exactly was checked.

For each finding give `file:line`, what is wrong, which rule it breaks (and where it is written), and a one-line fix. If there is nothing to
report, say so, without praise or filler.

**Step 5. Only with `run`.** For each touched package or app, one by one, run the project's own lint, test and build commands (find them in
`package.json` scripts, the `Makefile`, CI config or the docs), plus end-to-end tests if they were changed. Prefer commands scoped to the
touched packages over whole-repository ones. Only linter warnings introduced by the diff count as new. If the infrastructure hangs, don't
retry in a loop: say so and do a cheaper check instead.

$ARGUMENTS
