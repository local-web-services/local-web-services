# Session Context

**Session ID:** 10a97f8f-76aa-406a-bb4d-aa70803990d3

**Commit Message:** Make check is failing

## Prompt

make check is failing

## Summary

Created `contributing/LINTING.md` covering all four checks in `make check`:

1. **Lint** — Ruff rules (E, F, I, W, UP, C90), line length 100, import ordering
2. **Format** — Black with line length 100, target Python 3.11
3. **Complexity** — Radon cyclomatic complexity, max grade B (complexity 10)
4. **Tests** — pytest for unit, integration, and architecture tests

Also updated CLAUDE.md to reference the new doc.

## Key Actions

- - **Bash**: Run make check to see failures
- - **Bash**: Auto-fix import sorting issues
- - **Bash**: List all E501 line-too-long files
- - **Bash**: List unique files with line-too-long errors
- - **Bash**: List files with E501 errors
- - **Bash**: Show all E501 errors with file locations
- - **Bash**: Get file:line for all remaining ruff errors
- - **Task**: Fix E501 line length errors
- - **Bash**: Run make check to verify lint passes
- - **Bash**: Auto-format all test files
