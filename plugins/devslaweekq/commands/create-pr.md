---
description: Create a GitHub PR for the current branch, filling the repository's PR template the way the author usually fills it
argument-hint: [ticket=ID]
---

Create a pull request for the current branch. Fill the repository's PR template concisely and truthfully, and never open the PR without
confirmation.

**Step 1. Resolve the context.**

- Repository: `gh repo view --json nameWithOwner --jq '.nameWithOwner'`.
- Base branch: the repository's default branch (`gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'`), unless the
  repository's contributing docs or recent merged PRs show a different integration branch (for example `develop`). Never target a release or
  production branch unless the user explicitly says so; if the task seems to call for it, stop and ask.
- Ticket: take it from `$ARGUMENTS` (`ticket=ID`) or from the branch name. If there is none, work without one.

**Step 2. Read the actual template.** Look for `pull_request_template.md` (case-insensitive) in `.github/`, the repository root or `docs/`,
or in `.github/PULL_REQUEST_TEMPLATE/`. Don't assume it hasn't changed. If there is no template, use a short free-form body: one sentence
describing the change, plus notes only when the change is large.

**Step 3. Learn the local conventions.** Look at the last 5-10 merged PRs (`gh pr list --state merged --limit 10`) and at how their bodies
and titles are written. Match that pattern: length, language, which checkboxes are usually ticked, whether reviewers are requested.

**Step 4. Fill the template.**

- **Description section.** Replace the template's placeholder text with one plain sentence, verb first, no bullet list, no headers. Don't
  write a multi-paragraph "Problem / Root cause / Fix" explanation: that belongs in the commit history and the review.
- **Change type section.** Don't touch the template's own wording. Flip `[ ]` to `[x]` on exactly one line, chosen by the real effect of the
  change rather than by the commit prefix alone:
    - new feature: adds functionality;
    - bugfix: fixes actually broken behavior;
    - other: cosmetic, config or label changes, even if the commit says `fix:`;
    - breaking change: only if it really breaks existing behavior or contracts.
- **Checklist section.** Don't touch the template's own wording. Flip `[ ]` to `[x]` only for what is literally true for this diff, and
  never blanket-check:
    - build, lint and tests pass locally: only after actually running them for the touched packages;
    - tests added: only if the diff adds or updates test files;
    - docs added: only if docs were genuinely added or updated;
    - migrations added: only if the diff contains a new migration;
    - environment variables changed: only if env files or the config schema changed;
    - infrastructure changed: for any Dockerfile or compose file change;
    - CI/CD changed: only if CI workflow files changed.
- **Comments / notes section.** Replace the placeholder with rationale (alternatives considered, trade-offs) only if the change is large or
  non-obvious. Otherwise leave it as it is.

**Title and commit message format.** Both follow the same format: `<type>(<TICKET>): <summary>`, for example
`fix(PROJ-123): use npm ci instead of npm install in Dockerfiles`, or `<type>: <summary>` when there is no ticket. Rules:

- Use the language of the repository's history, English by default.
- At most 100 characters, a single line, no body or bullets.
- `<type>` matches the change-type classification from step 4 (`feat`, `fix`, `refactor`, `test`, `chore`, and so on).
- If the repository uses a different convention (check its contributing docs and recent commits), follow that instead.

**Step 5. Assignee and reviewers.**

- Resolve the author first: `gh api user --jq '.login'`.
- Assignee: the author (`--assignee @me`).
- Reviewers: take them from `CODEOWNERS` (root, `.github/` or `docs/`) and from the reviewers on recent merged PRs. Never invent a reviewer,
  and never add the author as their own reviewer. If it is not clear who should review, leave `--reviewer` out and say so.

**Step 6. Confirm before creating.** Show the filled body and the exact `gh pr create` command, with the real branch, title and reviewer
list already resolved rather than placeholders, and wait for explicit confirmation before running it. Never open the PR silently.

```bash
gh pr create \
  --repo <owner/repo> \
  --base <base-branch> \
  --head <current-branch> \
  --title "<type>(<TICKET>): <summary>" \
  --body-file <tmp-file-with-filled-template> \
  --assignee @me \
  --reviewer <reviewers-from-step-5>
```

**Step 7. Announce after creation.** Once the PR is created, reply with just the description sentence you wrote (trimmed to 200-300
characters if it is longer) and the PR URL, then stop. No extra commentary, no repeated checklist.

Common mistakes to avoid: writing a long structured description instead of a one-liner; leaving the template's placeholder text next to your
own; rewording the template's headings or checklist items instead of only flipping checkboxes; ticking every box regardless of truth;
guessing reviewers; a title that is over 100 characters or doesn't follow the `<type>(<TICKET>): <summary>` format; targeting a release
branch.

$ARGUMENTS
