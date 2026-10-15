# Global instructions

These apply in every project. When a project has its own conventions (its `CLAUDE.md`, contributing guide, linter
config or commit history), follow those where they differ from this file.

## Git

- Make atomic commits: one logical change each, which builds and passes tests on its own. Don't mix refactors,
  formatting and behaviour changes in one commit.
- Use Conventional Commits (`type(scope): summary`, e.g. `feat`, `fix`, `refactor`, `test`, `docs`, `chore`), with an
  imperative summary of at most 72 characters.
- Always write a body, wrapped at 72 columns, that explains what changed and why: the problem, the reason for this
  approach, and any trade-offs or alternatives rejected. The diff already shows how.
- Mark breaking changes with `!` and a `BREAKING CHANGE:` footer.
- Never push, force-push, or create, merge or close remote branches, tags, PRs or releases unless I ask in that
  conversation. Pushing is my job. Commit locally and tell me what is ready.
- Never rewrite history that has already been pushed. Never bypass hooks or signing (`--no-verify`, `--no-gpg-sign`);
  if one fails, fix the cause or stop and tell me.

## Security

- Treat security as part of every change. Validate untrusted input, use parameterised queries, encode output, and use
  least privilege.
- Never commit secrets, tokens, keys or credentials, and never print them in output. Use environment variables or the
  project's secret store. If you find a secret in the code, tell me.
- Prefer well-maintained, widely used dependencies, and add new ones only when needed. Pin versions and say why each
  new dependency is worth it.
- Be careful with commands that touch the network, delete data or change system state. Ask before running anything
  destructive or irreversible.
- Call out security-relevant consequences of a change, even when nobody asked.

## Quality

- Aim for 100% test coverage of new and changed code where feasible. Cover edge cases and error paths, not only the
  happy path. When something can't reasonably be tested, say what and why rather than leaving it silently uncovered.
- Write the failing test first when fixing a bug.
- Before calling work done, run the project's tests, linter, formatter and type checker, and fix what they report.
  Don't silence warnings or lower thresholds to get a pass.
- Check spelling in code, comments, docs and commit messages. Use `typos` or `codespell` if installed.
- Report results honestly: if something fails or was skipped, say so with the output.

## Code

- Match the surrounding code's style, naming and idioms. Keep changes focused on the task and mention unrelated issues
  instead of fixing them on the side.
- Prefer simple, readable code over clever code. Comments explain why, not what.
- Update docs, changelogs and examples when behaviour changes.

## Tooling

- At the start of work in a project, note its languages. If a code-intelligence (LSP) plugin exists for them in the
  official marketplace (e.g. `rust-analyzer-lsp` for Rust) and isn't enabled, suggest enabling it for that project
  in its `.claude/settings.json` under `enabledPlugins`, not globally. Mention that its language server must be
  installed too. Suggest it once; don't enable it without asking.
- Prefer the LSP for navigation, references and diagnostics over text search when it is available.
