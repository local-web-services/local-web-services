# Change: Fix Lifecycle Guard Coverage Regression

## Why

The `add-lifecycle-completion-injection` change added a Makefile filter
(`-m "guard and not internal and not lifecycle and not capacity"`) to prevent
five inject_state 404 errors from turning into test failures. The filter was
too broad: it excluded all 437 `@guard @lifecycle` scenarios from the guard
run, not just the five that were failing. As a result, the
`python-sdk-test-e2e-guard` CI job dropped from 1030 to 581 passing tests — a
loss of 449 tests that were either already passing or had just been made
runnable by the lifecycle injection work.

The root cause is that `LwsSession.inject_state()` raises `RuntimeError` for
any non-200 response, including 404 "resource not tracked". When a step
definition calls inject_state for a resource that exists in a service with a
registered tracker but has not yet been created in that tracker, the API
returns 404 and the test fails rather than skips. The Makefile filter treated
this as unrecoverable by excluding entire marker classes.

## What Changes

- `LwsSession.inject_state()` SHALL call `pytest.skip()` instead of raising
  `RuntimeError` when the management API returns 404 with a "not tracked"
  body, so tests that cannot inject state are skipped rather than failed.
- The Makefile `test-e2e-guard`, `test-e2e-minimal`, and `test-e2e-sequence`
  targets SHALL remove the `and not internal and not lifecycle and not
  capacity` exclusions, restoring all tagged scenarios to the run.
- The same change applies to `lang/python/example/Makefile`.

## Impact

- Affected specs: `python-async-state-injection`
- Affected code:
  - `lang/python/sdk/src/lws_testing/_management/state.py` — inject_state error handling
  - `lang/python/sdk/src/lws_testing/session.py` — LwsSession.inject_state
  - `lang/python/sdk/Makefile` — e2e target marker expressions
  - `lang/python/example/Makefile` — e2e target marker expressions
