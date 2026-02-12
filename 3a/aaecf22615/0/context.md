# Session Context

**Session ID:** db83720a-accc-4822-8e52-f37321f1ca3b

**Commit Message:** Implement the following plan:

# Plan: Experimental Service/Command Regi

## Prompt

Implement the following plan:

# Plan: Experimental Service/Command Registry

## Context

Nine new services were recently added (DocDB, ElastiCache, Elasticsearch, Glacier, MemoryDB, Neptune, OpenSearch, RDS, S3 Tables). They are all control-plane stubs and should be marked as experimental so users know they may change and so the team can track maturity over time. There is currently no concept of "experimental" anywhere in the codebase.

The user wants:
- **Service + command level** granularity (mark entire services or individual commands)
- **Three visibility surfaces**: CLI help text, runtime warning on invocation, and `ldk dev` startup banner

## Approach

### 1. Create a central experimental registry

**New file:** `src/lws/cli/experimental.py`

A single module that defines which services and commands are experimental. This is the one place to update when promoting a service to stable.

```python
# Services where every command is experimental
EXPERIMENTAL_SERVICES: set[str] = {
    "docdb",
    "elasticache",
    "es",
    "glacier",
    "memorydb",
    "neptune",
    "opensearch",
    "rds",
    "s3tables",
}

# Individual commands that are experimental (service, command-name)
# Use this when only specific commands within a stable service are experimental.
EXPERIMENTAL_COMMANDS: set[tuple[str, str]] = set()


def is_experimental_service(service: str) -> bool:
    ...

def is_experimental_command(service: str, command: str) -> bool:
    ...
```

Helper functions check both levels: a command is experimental if it's in `EXPERIMENTAL_COMMANDS` OR its parent service is in `EXPERIMENTAL_SERVICES`.

### 2. Tag help text on experimental service typers

**File:** `src/lws/cli/lws.py`

After each `app.add_typer(...)`, the help text is already set in the service module's `typer.Typer(help=...)`. Instead of modifying every service module, wrap the `add_typer` calls for experimental services to append `[experimental]` to the help string:

```python
from lws.cli.experimental import EXPERIMENTAL_SERVICES

# Helper to register with experimental tag
def _add_service(typer_app: typer.Typer, name: str) -> None:
    if name in EXPERIMENTAL_SERVICES:
        # Typer uses the help kwarg on add_typer; override it
        original_help = typer_app.info.help or ""
        app.add_typer(typer_app, name=name, help=f"{original_help} [experimental]")
    else:
        app.add_typer(typer_app, name=name)
```

This means `lws --help` shows:
```
neptune    Neptune commands [experimental]
glacier    Glacier commands [experimental]
dynamodb   DynamoDB commands
```

### 3. Print runtime warning on experimental command invocation

**File:** `src/lws/cli/experimental.py`

Add a `warn_if_experimental` function that prints a stderr warning:

```python
import sys

def warn_if_experimental(service: str, command: str | None = None) -> None:
    """Print a warning to stderr if the service or command is experimental."""
    if command and (service, command) in EXPERIMENTAL_COMMANDS:
        print(f"Warning: '{service} {command}' is experimental and may change.", file=sys.stderr)
    elif service in EXPERIMENTAL_SERVICES:
        print(f"Warning: '{service}' is experimental and may change.", file=sys.stderr)
```

**Files:** Each experimental service module (9 files in `src/lws/cli/services/`)

Add a typer callback to each experimental service's typer app that calls `warn_if_experimental`. Typer callbacks run before any command in the group:

```python
# In e.g. src/lws/cli/services/neptune.py
from lws.cli.experimental import warn_if_experimental

app = typer.Typer(help="Neptune commands")

@app.callback(invoke_without_command=True)
def _callback() -> None:
    warn_if_experimental("neptune")
```

This fires once per invocation — `lws neptune create-db-cluster ...` prints `Warning: 'neptune' is experimental and may change.` to stderr before executing the command.

For command-level experimental (future use), individual commands would call `warn_if_experimental("service", "command")` directly.

### 4. Show experimental services in `ldk dev` startup banner

**File:** `src/lws/cli/ldk.py`

Add a function that prints the experimental services banner after the existing endpoint summary in `_run_dev_terraform`:

```python
from lws.cli.experimental import EXPERIMENTAL_SERVICES

def _print_experimental_banner(ports: dict[str, int]) -> None:
    active = sorted(s for s in EXPERIMENTAL_SERVICES if s in ports)
    if not active:
        return
    _console.print("[bold yellow]Experimental services:[/bold yellow]")
    _console.print(f"  {', '.join(active)}")
    _console.print("[dim]  These services may change or be removed in future releases.[/dim]")
    _console.print()
```

Called in `_run_dev_terraform` after the service endpoints listing, and in `_run_dev` CDK mode after `_display_summary`.

### 5. Add architecture test for registry completeness

**New file:** `tests/architecture/tests/test_experimental_registry.py`

Ensure every entry in `EXPERIMENTAL_SERVICES` actually corresponds to a real service module, and every entry in `EXPERIMENTAL_COMMANDS` corresponds to a real command. Prevents stale entries after renames/removals.

### 6. Unit test the experimental module

**New file:** `tests/unit/cli/test_experimental.py`

Test `is_experimental_service`, `is_experimental_command`, and `warn_if_experimental` output.

## Files Modified

| File | Change |
|------|--------|
| `src/lws/cli/experimental.py` | **NEW** — Registry + helper functions |
| `src/lws/cli/lws.py` | Use `_add_service()` helper to tag help text |
| `src/lws/cli/ldk.py` | Add `_print_experimental_banner()`, call it in both terraform and CDK startup paths |
| `src/lws/cli/services/neptune.py` | Add typer callback with `warn_if_experimental` |
| `src/lws/cli/services/docdb.py` | Add typer callback with `warn_if_experimental` |
| `src/lws/cli/services/elasticache.py` | Add typer callback with `warn_if_experimental` |
| `src/lws/cli/services/es.py` | Add typer callback with `warn_if_experimental` |
| `src/lws/cli/services/glacier.py` | Add typer callback with `warn_if_experimental` |
| `src/lws/cli/services/memorydb.py` | Add typer callback with `warn_if_experimental` |
| `src/lws/cli/services/opensearch.py` | Add typer callback with `warn_if_experimental` |
| `src/lws/cli/services/rds.py` | Add typer callback with `warn_if_experimental` |
| `src/lws/cli/services/s3tables.py` | Add typer callback with `warn_if_experimental` |
| `tests/architecture/tests/test_experimental_registry.py` | **NEW** — Validate registry entries match real services/commands |
| `tests/unit/cli/test_experimental.py` | **NEW** — Unit tests for experimental module |

## Verification

```bash
# Unit tests:
uv run pytest tests/unit/cli/test_experimental.py -v

# Architecture tests:
uv run pytest tests/architecture/ -v

# Full check:
make check

# Manual:
lws --help                    # Services show [experimental] tag
lws neptune --help            # Shows [experimental] in group help
lws neptune create-db-cluster --db-cluster-identifier foo
  # stderr: Warning: 'neptune' is experimental and may change.
lws ldk dev                   # Startup banner lists experimental services
```


If you need specific details from before exiting plan mode (like exact code snippets, error messages, or content you generated), read the full transcript at: /Users/eamonnfaherty/.REDACTED.jsonl

## Summary

All done. Here's a summary of what was implemented:

## Changes Made

### New files
| File | Purpose |
|------|---------|
| `src/lws/cli/experimental.py` | Central registry with `EXPERIMENTAL_SERVICES`, `EXPERIMENTAL_COMMANDS`, `is_experimental_service()`, `is_experimental_command()`, and `warn_if_experimental()` |
| `tests/architecture/tests/test_experimental_registry.py` | Validates registry entries match real services registered in `lws.py` |
| `tests/unit/cli/test_experimental.py` | Tests for `is_experimental_service` |
| `tests/unit/cli/test_experimental_command.py` | Tests for `is_experimental_command` |
| `tests/unit/cli/test_experimental_warn.py` | Tests for `warn_if_experimental` |

### Modified files
| File | Change |
|------|--------|
| `src/lws/cli/lws.py` | Added `_add_service()` helper that appends `[experimental]` to help text for services in `EXPERIMENTAL_SERVICES` |
| `src/lws/cli/ldk.py` | Added `_print_experimental_banner()` called in both Terraform and CDK startup paths |
| 9 service modules (`neptune`, `docdb`, `elasticache`, `es`, `glacier`, `memorydb`, `opensearch`, `rds`, `s3tables`) | Added `@app.callback` that calls `warn_if_experimental()` on invocation |

### Three visibility surfaces
1. **CLI help text** — `lws --help` shows `[experimental]` next to experimental services
2. **Runtime warning** — Invoking any experimental service prints `Warning: '<service>' is experimental and may change.` to stderr
3. **Startup banner** — `ldk dev` prints a yellow "Experimental services" banner listing active experimental services

### Test results
- 21/21 tests pass (12 new + 9 existing `test_lws.py` tests confirming no regressions)
- Linting and formatting clean
- 7 pre-existing failures unrelated to this change (docker socket tests, `_shared_commands` registration, multi-class test files from recent service additions)

## Key Actions

- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/lws.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/ldk.py
- - **Glob**: src/lws/cli/services/*.py
- - **Glob**: tests/architecture/**/*.py
- - **Glob**: tests/unit/cli/*.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/neptune.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/docdb.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/elasticache.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/es.py
- - **Read**: /Users/eamonnfaherty/Development/github.com/local-web-services/local-web-services/src/lws/cli/services/glacier.py
