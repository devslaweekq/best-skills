---
description:
    Go through unresolved review threads on a PR, classify each (fix / disagree / clarify), draft replies and optionally apply the fixes
argument-hint: [PR number or URL]
---

Go through the unresolved review comments on a PR. Don't publish or resolve anything without an explicit "yes".

**Step 1. Find the PR.** Use the number or link from $ARGUMENTS. If empty, use the PR of the current branch:
`gh pr view --json number,url,headRefName`.

**Step 2. Collect the threads.** Only unresolved ones (`isResolved: false`), including outdated ones (`isOutdated: true`), which you mark
separately. Use `mcp__github__pull_request_read` (`get_review_comments`) or `gh api graphql` over `reviewThreads`. For each thread: author,
file, line, the whole conversation. Mark human authors and bots separately.

**Step 3. Read the code.** For each thread, open the file at the current HEAD of the PR branch at the given place. Check outdated threads in
particular: a later commit may already have fixed the problem.

**Step 4. Classify.** One of these for each thread:

- `fix`: the comment is right, change the code;
- `already`: already fixed (name the commit);
- `disagree`: the comment is wrong or doesn't apply (one sentence on why, with a fact from the code);
- `clarify`: it's unclear what the reviewer wants, a question is needed;
- `skip`: off-topic or bot noise, no reply needed.

Check bot comments as strictly as human ones: they are often wrong or about files outside the diff.

**Step 5. Show a table.** One row per thread: `#`, author, file:line, the gist of the comment in 5-8 words, class, what you propose to do.
Below it, a draft reply for every `disagree`, `clarify`, `already` and non-obvious `fix`. Write the replies following the `human-comments`
skill: short, no preamble, just `done` where the fix is obvious.

**Step 6. Wait for the choice.** The user says what to fix, what to argue about and what to skip.

**Step 7. Fix.** Only the selected `fix` items, and only what the comments ask for, with no side changes. Follow the repository's own rules
(`CLAUDE.md`, contributing docs), and run tests and lint for the touched packages with the project's own commands. Don't commit or push
without confirmation.

**Step 8. Replies.** Output the final reply texts per thread, ready to paste. Publish to the PR (`add_reply_to_pull_request_comment`) only
if the user explicitly asked. Don't resolve threads.

$ARGUMENTS
