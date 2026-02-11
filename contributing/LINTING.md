# Linting and Formatting Standards

All code must pass `make check` and `make test-e2e` before merging. This runs seven checks:

## 1. Lint (`make lint`)

```
uvx ruff check src tests
```

Uses [Ruff](https://docs.astral.sh/ruff/) with these rule sets (configured in `pyproject.toml`):

| Code | Category | What it catches |
|------|----------|----------------|
| `E` | pycodestyle errors | Syntax issues, line length (max 100), whitespace |
| `F` | pyflakes | Unused imports, undefined names, redefined variables |
| `I` | isort | Import ordering — stdlib, third-party, then first-party (`lws`) |
| `W` | pycodestyle warnings | Trailing whitespace, blank lines |
| `UP` | pyupgrade | Outdated syntax that can use newer Python 3.11+ features |
| `C90` | mccabe | Cyclomatic complexity (max 10 per function) |

**Auto-fix most issues:**

```
uvx ruff check --fix src tests
```

**Key rules:**

- Line length: 100 characters max (exception: `src/lws/api/gui.py`)
- Imports must be sorted: stdlib, third-party, first-party (`lws`)
- No unused imports or variables
- Target Python version: 3.11

## 2. Format Check (`make format-check`)

```
uvx black --check src tests
```

Uses [Black](https://black.readthedocs.io/) to enforce consistent formatting.

- Line length: 100 characters
- Target Python version: 3.11
- Deterministic — same input always produces same output

**Auto-format:**

```
make format
```

or equivalently:

```
uvx black src tests
```

## 3. Complexity Check (`make complexity`)

```
uvx radon cc src -a -nc
```

Uses [Radon](https://radon.readthedocs.io/) to measure cyclomatic complexity. All functions must be **grade B or better** (complexity 10 or less). The `-nc` flag reports only grade C and worse — any output means failure.

| Grade | Complexity | Status |
|-------|-----------|--------|
| A | 1–5 | Pass |
| B | 6–10 | Pass |
| C | 11–15 | **Fail** |
| D+ | 16+ | **Fail** |

**To fix:** extract helper functions to reduce branching. Common strategies:
- Replace chained `if/elif` with a dispatch dict or loop
- Extract nested logic into a dedicated helper
- Use data-driven patterns (tuples/lists of descriptors) instead of repeated conditional blocks

## 4. Copy-Paste Detection (`make cpd`)

```
uvx --from pylint symilar -d 5 --ignore-imports --ignore-docstrings --ignore-signatures $(find src -name "*.py")
```

Uses [symilar](https://pylint.readthedocs.io/en/latest/symilar.html) (part of pylint) to detect duplicated code blocks. Any block of 5 or more similar lines in `src/` is flagged.

- **Scope**: `src/` only — tests are excluded because test files are intentionally repetitive by design
- **Threshold**: 5 minimum duplicate lines (`-d 5`)
- **Ignored**: imports, docstrings, and signatures (these are often legitimately similar)

**To fix:** extract the shared logic into a common module and import from both call sites. Typical locations for shared code:

- `src/lws/providers/_shared/` — utilities shared across providers
- A helper module alongside the duplicating files (e.g. `result_parser.py`)

## 5. Pylint (`make pylint`)

```
uvx --from pylint pylint src/lws --recursive=y
```

Uses [pylint](https://pylint.readthedocs.io/) for deep static analysis. Configuration is in `pyproject.toml` under `[tool.pylint]`.

**Globally disabled checks** (handled by other tools or project conventions):

| Code | Symbol | Reason |
|------|--------|--------|
| `E0401` | import-error | False positive under `uvx` (no venv) |
| `W0718` | broad-exception-caught | Suppressed globally per project decision |
| `R0801` | duplicate-code | Handled by `make cpd` |
| `C0301` | line-too-long | Handled by ruff/black |
| `C0302` | too-many-lines | Handled by ruff |
| `C0114` | missing-module-docstring | Not enforced |
| `C0115` | missing-class-docstring | Not enforced |
| `R0903` | too-few-public-methods | Dataclass/protocol pattern |
| `R0902` | too-many-instance-attributes | Config objects |
| `R0913` | too-many-arguments | Structural |
| `R0917` | too-many-positional-arguments | Structural |
| `R0904` | too-many-public-methods | Provider pattern |
| `R0911` | too-many-return-statements | Structural |
| `R0914` | too-many-locals | Structural |
| `C0103` | invalid-name | Naming conventions differ |
| `W0603` | global-statement | Used sparingly, intentional |
| `W0621` | redefined-outer-name | Rare, intentional |

**Common fixes:**

- **W0613 (unused-argument):** Prefix with `_` (e.g. `body` → `_body`)
- **W0212 (protected-access):** Add `@property` accessors to expose private attributes
- **C0415 (import-outside-toplevel):** Add `# pylint: disable=import-outside-toplevel` for intentional lazy imports
- **W2301 (unnecessary-ellipsis):** Remove `...` from abstract methods that have docstrings
- **W0707 (raise-missing-from):** Add `from exc` to re-raises

## 6. Test Suite (`make test`)

```
uv run pytest --ignore=tests/e2e
```

Runs all unit, integration, and architecture tests. All tests must pass.

## 7. E2E Tests (`make test-e2e`)

```
uv run pytest tests/e2e/ -v
```

Runs end-to-end tests that exercise the CLI commands against a running local instance. These run in CI as a separate parallel job and as part of the pre-commit hook.

## Quick Reference

| Command | Purpose |
|---------|---------|
| `make check` | Run all checks (what CI runs) |
| `make lint` | Lint only |
| `make format` | Auto-format code |
| `make format-check` | Check formatting without changes |
| `make complexity` | Check complexity (grade B or better) |
| `make cpd` | Check for duplicated code (5+ lines) |
| `make pylint` | Run pylint static analysis |
| `make test` | Run test suite (excludes e2e) |
| `make test-e2e` | Run e2e tests |
| `uvx ruff check --fix src tests` | Auto-fix lint issues |

## Before Submitting a PR

Run `make check` and fix any failures. Most formatting and import issues can be auto-fixed:

```bash
uvx ruff check --fix src tests  # fix lint issues
make format                      # fix formatting
make check                       # verify everything passes
```
