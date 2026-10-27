# best-skills

A Claude Code skills marketplace by devslaweekq. The structure and the rules for adding skills and commands are described in `README.md`.

## Bump the version after changes

Claude Code caches a plugin by the version number in `plugins/devslaweekq/.claude-plugin/plugin.json`. If the version doesn't change,
`/plugin marketplace update` pulls nothing, and the changes never reach other users.

After any change in `plugins/devslaweekq/` (a new or changed skill, command or helper file), release right away with `scripts/release.sh`,
without waiting for a reminder from the user:

```bash
scripts/release.sh "feat: add <name> skill" minor   # new skill or command
scripts/release.sh "fix: <what was fixed>"          # change to an existing one (patch by default)
scripts/release.sh "feat: <what> (breaking)" major  # breaking change, only when explicitly asked
```

- The script does `git add -A`, a commit, an annotated tag `vX.Y.Z`, and pushes the commit and the tag to `origin`. Check `git status`
  before running it: the tree must contain only your changes.
- Don't edit the version in `plugin.json` by hand and don't make extra commits for it; the script does all of that.
- Commit messages use the `feat:` / `fix:` / `chore:` format.
- In this environment the repository may have no git identity, and `git commit` then fails with `Author identity unknown`. Don't touch
  `git config`; run the script with `GIT_AUTHOR_NAME`, `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME` and `GIT_COMMITTER_EMAIL` set in the
  environment (values from `git config` of another of the user's repositories). Re-running after a failure bumps the version again; in that
  case finish the commit, tag and push by hand.
- If you change only `README.md` or `CLAUDE.md`, with nothing under `plugins/`, don't bump the version.
- After a release, tell the user to run `/plugin marketplace update devslaweekq-skills` and `/reload-plugins`.
