---
name: discover
description: Front-load pattern discovery before implementing an OpenSpec change. Reads existing similar implementations to surface conventions, wiring patterns, file-length risks, and parallel workstreams.
argument-hint: <change-id>
context: fork
agent: Explore
allowed-tools: Read, Grep, Glob, Bash
---

Prepare a pattern discovery report for OpenSpec change: $ARGUMENTS

## Steps

1. Read `openspec/changes/$ARGUMENTS/tasks.md` to understand the full scope of work.

2. Identify the implementation type (new provider, SDK wiring, middleware, E2E suite, etc.) and find 1–2 existing implementations of the same type to use as a reference:
   - New provider → read an existing provider's `routes.py`, unit tests, integration tests, and E2E suite (e.g. `lang/python/core/src/lws/providers/sqs/`)
   - SDK wiring → read `lang/python/sdk/src/lws_testing/_transport/inprocess.py` and `_extended_services.py`
   - Shared middleware → read an existing middleware file and its wiring across provider routes
   - E2E suite → read an existing suite's `given/`, `when/`, `then/`, `conftest.py`, `constants.py`

3. For every file that will be **modified** (not created), check its current line count with `wc -l`. Flag any file within 50 lines of the 500-line architecture limit.

4. Group the tasks from `tasks.md` into parallel workstreams — identify which groups have no dependencies on each other and can run concurrently.

## Output

Produce a structured report with these sections:

### Reference implementations used
List the files you read and why they were chosen.

### Key patterns to follow
- Naming conventions (files, classes, functions)
- Import style
- Required boilerplate (e.g. AAA comments, `# Arrange`/`# Act`/`# Assert`)
- Any non-obvious conventions (e.g. how `X-Amz-Target` headers are parsed, boto3 parameter names)

### File-length risks
Table of files to be modified with current line count. Mark files within 50 lines of 500 as ⚠️. Suggest extraction targets if a file will exceed the limit.

### Parallel workstreams
Group task numbers from `tasks.md` into independent workstreams that can run concurrently. Example:
- Workstream A (core provider): tasks 1–3, 6–9
- Workstream B (SDK wiring): tasks 4–5
- Workstream C (E2E suite): tasks 8 (depends on A)

### Gotchas
Specific pitfalls found in the reference code that are easy to miss:
- e.g. boto3 sends `X-Amz-Target` with full namespace prefix, not just the action name
- e.g. `sqs.create_queue` raises if queue already exists — wrap in try/except in Given steps
- e.g. `StartTime`/`EndTime` arrive as Unix timestamps, not ISO strings
