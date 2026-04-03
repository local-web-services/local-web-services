## 1. SDK State Module

- [x] 1.1 In `lang/python/sdk/src/lws_testing/_management/state.py`, update `inject_state()` to distinguish 404 "not tracked" responses from other errors — raise a dedicated `InjectStateNotTracked` exception for that case only

## 2. LwsSession

- [x] 2.1 In `lang/python/sdk/src/lws_testing/session.py`, keep `LwsSession.inject_state()` auto-skipping on `InjectStateNotTracked` (for Given steps); add `inject_state_unchecked()` that converts `InjectStateNotTracked` to `RuntimeError` (for When steps); bulk-update all 131 When step files to use `inject_state_unchecked()` so they continue to capture the rejection in `world["error"]`

## 3. Makefile Cleanup

- [x] 3.1 In `lang/python/sdk/Makefile`, change `test-e2e-minimal`, `test-e2e-guard`, and `test-e2e-sequence` marker expressions back to `-m minimal`, `-m guard`, and `-m sequence` (remove `and not internal and not lifecycle and not capacity`)
- [x] 3.2 Apply the same revert to `lang/python/example/Makefile`

## 4. Tests

- [x] 4.1 Add unit tests in `lang/python/sdk/tests/unit/` for `inject_state` 404 → skip behaviour and `inject_state_unchecked` 404 → `RuntimeError`
- [x] 4.2 Add a unit test confirming that 409 and 400 responses still raise `RuntimeError`

## 5. Validation

- [x] 5.1 Run `make -C lang/python/sdk test-unit` — all unit tests pass
- [x] 5.2 Run `make -C lang/python/sdk test-e2e-guard SUITE=tests/e2e/elasticache` locally to confirm the guard run collects lifecycle scenarios and skips (not fails) the ones that cannot inject state
- [ ] 5.3 Confirm CI `python-sdk-test-e2e-guard` job recovers to ≥ 900 passing tests (close to the PR #60 baseline of 1030)
