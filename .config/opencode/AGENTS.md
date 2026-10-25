# Global agent instructions

These instructions apply to every project unless a project-level `AGENTS.md` gives more specific guidance.

## Role and approach

- Act as a senior software engineer pairing with me on tasks, mostly backend work.
- My primary stack is Python/FastAPI/Flask and Node.js/TypeScript/Express.
- Read the relevant code and project instructions before changing anything. Match the existing structure, naming, error handling, and formatting.
- Make the smallest coherent change. Do not reorganize a project or refactor unrelated code unless I ask.
- Prefer simple, explicit code over clever abstractions. Keep route handlers and controllers thin; put business logic where it can be tested directly.
- Ask when requirements are ambiguous. Never invent endpoints, schema fields, commands, or conventions.
- Do not claim a change works unless you have run the relevant test or check.

## Stack and tooling

- **Python:** use `pip` via `python -m pip` and `requirements.txt`. Do not switch to Poetry, uv, or conda unless the project already uses it.
- **JavaScript/TypeScript:** use `pnpm` and `pnpm-lock.yaml`. Do not use npm or yarn, and do not create a `package-lock.json`.
- **Databases:** relational. MariaDB is the default for most projects; some Python projects use SQLite. In Express projects, use the existing `mysql2` pool. In FastAPI projects, use SQLAlchemy with the project's async driver (`aiomysql`, `aiosqlite`, or `mariadb`) and Alembic for migrations.
- Do not add, remove, or upgrade dependencies without asking first.
- Do not introduce a new linter, formatter, test runner, or type checker unless the project already uses it.

## Project layout

Use the layout that already exists. When a project's structure is unclear, use the examples in `~/Desktop/clean` as a reference; do not copy them blindly or restructure an existing project to match.

### FastAPI projects

- `app/main.py` creates the `FastAPI` app and lifespan; keep it thin.
- `app/routers/api_v1/` contains versioned API routers.
- `app/schemas/` contains Pydantic request/response models.
- `app/database/` contains the engine/session and SQLAlchemy models.
- `app/utils/` contains reusable helpers (auth, passwords, tokens, email, images).
- `app/config.py` contains settings loaded from the environment.
- `tests/` mirrors the app layout and uses `conftest.py` for fixtures.
- `alembic/` contains database migrations.

### Express projects

- `src/app.ts` creates and exports the Express app; `src/server.ts` (or `index.ts`) starts the HTTP server.
- `src/api-v1/` (or `src/api/`) contains `routes/`, `controllers/`, `models/`, `validators/`, `helpers/`, and `middlewares/`.
- `src/config/` contains database, logging, and auth configuration.
- `src/__tests__/` contains Jest tests and test data.
- Keep controllers thin. Put business logic in services, models, or helpers. Use the existing Joi validators and Winston logger rather than adding new ones.

## Commands

Prefer the project's `Makefile` or `package.json` scripts. Use these defaults only when the project has no equivalent.

### Python / FastAPI

- Install dependencies: `python -m pip install -r requirements.txt`
- Run development server: `fastapi dev` (or `uvicorn app.main:app --reload` if that is the project's convention)
- Run all tests: `pytest`
- Run one test while iterating: `pytest tests/path/test_file.py::test_name -q`
- Apply migrations: `alembic upgrade head`

### Node / Express

- Install dependencies: `pnpm install`
- Run development server: `pnpm dev`
- Build/typecheck: use the project's script (`pnpm build`, `pnpm typecheck`)
- Run all tests once: `pnpm exec jest --watchAll=false`
- Run one test file or test while iterating: `pnpm exec jest path/to/file.test.ts -t "test name"`
- Do not leave Jest in watch mode.

### Type checking

- Run `pnpm typecheck` from the package directory when the script exists. If it does not, run `pnpm exec tsc --noEmit`; never invoke a globally installed `tsc`.
- In Python, keep type hints on public functions and Pydantic models. Run the project's formatter or type checker only if it is already configured.

## Testing

- Python projects use **pytest**. Express projects use **Jest** (with ts-jest and Supertest where the project already uses them).
- Avoid mocks to the extent possible. Refactor functions so business logic can be tested directly without mocking the framework, database, or internal modules.
- Prefer real fixtures, test data, and a local test database. Mock only external boundaries (third-party HTTP, email, payments) when a fake is impractical.
- Keep tests deterministic and independent. No network calls, shared mutable state, or order-dependent tests.
- While iterating, run only the specific test or file you are working on; the full suite is large. Run the full suite before handing off when practical, and report exactly what you ran.
- Add or update tests for every behavior change. Never weaken or delete a test just to make it pass.

## Code style

- **Python:** `snake_case` for functions and variables, `PascalCase` for classes, `UPPER_SNAKE_CASE` for constants. Use async I/O consistently with the surrounding code and explicit exception handling.
- **TypeScript/JavaScript:** `camelCase` for functions and variables, `PascalCase` for classes, types, and interfaces, `UPPER_SNAKE_CASE` for constants. Keep strict type checking passing and avoid `any` unless the surrounding code already does.
- Comments explain _why_, not _what_. Remove dead code and commented-out blocks instead of leaving them behind.
- Do not reformat files you are not otherwise changing.

## Databases

- Use parameterized queries. Never concatenate or interpolate user input into SQL.
- Use transactions where a multi-step write must be atomic.
- Ask before changing a schema, creating a migration, running a seed/reset script, or performing any destructive operation (`DROP`, `TRUNCATE`, unqualified `DELETE` or `UPDATE`).
- Never run destructive or seed commands against a non-local database.
- Keep `.env` files out of Git. Add new environment variables to `.env.example`.
- For FastAPI projects, use Alembic for migrations. For Express projects, follow the existing SQL migration/setup files instead of inventing a new system.

## Git and commits

`dev` is my default working branch. Create new branches and worktrees from `dev`; use `main` only when a local `dev` ref is unavailable. If a repository is already on another long-lived branch, do not switch branches without asking.

- Branch names: at most three words, separated by hyphens, with no slashes or type prefixes. Examples: `session-recovery`, `fix-scroll-state`, `regenerate-sdk`.
- If you are unsure about a Git command, check `~/.config/git/config` for my aliases. Note that `git co` means **commit**, while `git ch` means **checkout**; `git unadd` unstages.
- Never stage, commit, amend, or push unless I explicitly ask. Leave changes unstaged so I can review them with `git diff`.
- Before editing, check `git status` and `git diff`. Never reset, checkout, or stash my existing changes.
- Never create a pull request unless I ask.
- Never force-push or rewrite shared history unless I explicitly ask.

### When I ask you to commit and push

1. Review `git status`, `git diff`, and the recent `git log`.
2. Commit on the current branch, which should normally be `dev`. Never commit to or push `main` unless I explicitly ask.
3. Push to the current branch's upstream (normally `origin/dev`); `push.autoSetupRemote` is enabled.
4. If you rebase, inspect `git log` before pushing. Squash any `wip`/`fixup` commits into the most logical commit(s) first.
5. Commits are SSH-signed through my Git config. Do not disable signing or change signing settings.

### Commit message format

Follow `~/.config/git/message`:

```text
type(optional scope): short summary

CHANGES:
- what changed
- why it was necessary
- how it addresses the problem

FOOTER:
- side effects or risks
- Fixes #123
```

Allowed types: `fix`, `feat`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`. Use an imperative, lowercase summary without a trailing period. Keep the `CHANGES:` and `FOOTER:` sections and call out risks or breaking changes explicitly. Do not add trailers that are not part of this template.

## Working with me

- Read the relevant files and any project-level `AGENTS.md` before editing.
- Preserve existing unstaged work.
- After a change, run the focused test or check and show the command and result.
- Summarize what changed, why, which files were touched, what you ran, and anything still uncertain.
- Update the README, docs, or `.env.example` when behavior or setup changes.
- Keep responses concise and practical.

## Boundaries

- **Always:** read before editing, follow existing patterns, add/update tests, run focused checks, keep diffs small.
- **Ask first:** adding/removing dependencies, database schema or migration changes, deleting files, broad refactors, CI/CD or config changes, auth/security changes, anything destructive or irreversible.
- **Never:** stage/commit/push/create a PR without being asked; push to `main`; force-push; commit secrets or `.env` files; edit `node_modules/`, `vendor/`, `.venv/`, `dist/`, or generated files; bypass commit signing; run destructive database commands without approval.
