# Session Context

**Session ID:** 2c1da5b5-66a2-4ca5-ad8d-26a15fc081b5

**Commit Message:** Implement the following plan:

# Plan: Add Copy-Paste Detector to `make

## Prompt

Implement the following plan:

# Plan: Add Copy-Paste Detector to `make check`

## Context

The project has linting (`ruff`), formatting (`black`), complexity (`radon`), and tests — but no copy-paste detection. Adding a CPD step catches duplicated code blocks before they accumulate.

## Tool Choice: `symilar` (from `pylint`)

`symilar` is pylint's built-in copy-paste detector. It:
- Runs via `uvx --from pylint symilar` (consistent with existing `uvx` pattern)
- Supports `--ignore-imports`, `--ignore-docstrings`, `--ignore-signatures`
- Has a `-d` flag for minimum duplicate lines threshold
- Is actively maintained as part of pylint

**Threshold**: `-d 15` (15 minimum lines).
**Scope**: Only `src/` (not tests — test files are intentionally repetitive by design).

`symilar` always exits 0 regardless of duplicates found. The Makefile target parses the `TOTAL` output line and fails if `duplicates=N` where N > 0.

## Existing Duplicates to Fix (3 pairs, 66 lines)

### Pair 1: Lambda invocation result parsing (24 lines)
- `src/lws/providers/lambda_runtime/nodejs.py:123–149`
- `src/lws/providers/lambda_runtime/python.py:151–177`
- **Fix**: Extract `_parse_invocation_output(raw, duration_ms, request_id) -> InvocationResult` into a shared module (e.g. `src/lws/providers/lambda_runtime/result_parser.py`) and call from both.

### Pair 2: Numeric comparison logic (21 lines)
- `src/lws/providers/eventbridge/pattern_matcher.py:120–154`
- `src/lws/providers/sns/filter.py:95–129`
- **Fix**: Extract `_eval_numeric_range()` and `_compare_numeric()` into a shared module (e.g. `src/lws/providers/_shared/numeric.py` or similar) and import from both.

### Pair 3: DynamoDB value unwrapping (21 lines)
- `src/lws/providers/dynamodb/expressions.py:530–559`
- `src/lws/providers/dynamodb/update_expression.py:399–428`
- **Fix**: Keep one copy (in `expressions.py` since it's the lower-level module) and import from `update_expression.py`.

## Changes

### 1. Fix duplicate pair 3: DynamoDB `_unwrap_dynamo_value` + `_resolve_path`
- Remove `_unwrap_dynamo_value` and `_resolve_path` from `update_expression.py`
- Import them from `expressions.py` instead

### 2. Fix duplicate pair 1: Lambda result parsing
- Create `src/lws/providers/lambda_runtime/result_parser.py` with `parse_invocation_output(raw, duration_ms, request_id) -> InvocationResult`
- Update `nodejs.py` and `python.py` to import and use it

### 3. Fix duplicate pair 2: Numeric comparison
- Create `src/lws/providers/_shared/__init__.py` and `src/lws/providers/_shared/numeric.py`
- Move `_eval_numeric_range()` and `_compare_numeric()` there
- Update `eventbridge/pattern_matcher.py` and `sns/filter.py` to import from shared

### 4. Add `cpd` target to `Makefile`

```makefile
cpd: ## Check for copy-pasted code (15+ similar lines)
	@output=$$(uvx --from pylint symilar -d 15 --ignore-imports --ignore-docstrings --ignore-signatures $$(find src -name "*.py")); \
	echo "$$output" | tail -1; \
	echo "$$output" | tail -1 | grep -q "duplicates=0 " || { echo "$$output"; exit 1; }
```

Update `check` to include `cpd`:
```makefile
check: lint format-check complexity cpd test
```

Update `.PHONY` to include `cpd`.

### 5. Update `contributing/LINTING.md`

Add section "5. Copy-Paste Detection (`make cpd`)" between complexity and test sections. Document the tool, threshold, scope, and how to fix violations. Renumber the test section to "6". Update quick reference table.

## Files Modified

| File | Action |
|------|--------|
| `src/lws/providers/dynamodb/update_expression.py` | **Edit** — remove duplicate `_unwrap_dynamo_value` + `_resolve_path`, import from `expressions.py` |
| `src/lws/providers/lambda_runtime/result_parser.py` | **Create** — shared invocation result parsing |
| `src/lws/providers/lambda_runtime/nodejs.py` | **Edit** — use shared result parser |
| `src/lws/providers/lambda_runtime/python.py` | **Edit** — use shared result parser |
| `src/lws/providers/_shared/__init__.py` | **Create** — shared utilities package |
| `src/lws/providers/_shared/numeric.py` | **Create** — shared numeric comparison |
| `src/lws/providers/eventbridge/pattern_matcher.py` | **Edit** — use shared numeric comparison |
| `src/lws/providers/sns/filter.py` | **Edit** — use shared numeric comparison |
| `Makefile` | **Edit** — add `cpd` target, add to `check` and `.PHONY` |
| `contributing/LINTING.md` | **Edit** — add CPD section, renumber, update quick reference |

## Verification

```bash
make cpd       # Should pass (0 duplicates after fixes)
make check     # Full pipeline passes
```


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

## Summary

All done. Here's a summary of what was implemented:

**Duplicate fixes (3 pairs, 66 lines removed):**

1. **DynamoDB** — Removed duplicate `_unwrap_dynamo_value` and `_resolve_path` from `update_expression.py`, now imported from `expressions.py`
2. **Lambda runtime** — Created `result_parser.py` with shared `parse_invocation_output()`, used by both `nodejs.py` and `python.py`
3. **Numeric comparison** — Created `_shared/numeric.py` with `eval_numeric_range()` and `compare_numeric()`, used by both `eventbridge/pattern_matcher.py` and `sns/filter.py`

**New `cpd` Makefile target:**
- Runs `symilar` (from pylint) with `-d 15` threshold on `src/` only
- Added to `check` target pipeline: `lint → format-check → complexity → cpd → test`

**Other changes:**
- Updated `contributing/LINTING.md` with CPD documentation (section 4, renumbered tests to section 5)
- Updated architecture test to exclude `_`-prefixed directories (like `_shared`) from provider completeness checks

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/update_expression.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/dynamodb/expressions.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/nodejs.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/lambda_runtime/python.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/eventbridge/pattern_matcher.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/providers/sns/filter.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/Makefile
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/contributing/LINTING.md
- - **TaskCreate**: Remove duplicate _unwrap_dynamo_value and _resolve_path from update_expression.py and import from expressions.py instead
- - **TaskCreate**: Create result_parser.py with parse_invocation_output and update nodejs.py and python.py to use it
