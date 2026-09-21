## 1. Core fix

- [ ] 1.1 Add `result` param to `_expand_value` in `jsonata_evaluator.py`
- [ ] 1.2 Update `evaluate_output` to recurse into dict values via `_expand_value`

## 2. Tests

- [ ] 2.1 Add dict-form Output unit tests to `test_stepfunctions_jsonata_evaluator_evaluate_output.py`
- [ ] 2.2 Add engine-level dict Output unit test

## 3. Gherkin and E2E

- [ ] 3.1 Add scenario to `jsonata_expression.feature`
- [ ] 3.2 Add constants + client method for dict-Output SM (SDK + core integration)
- [ ] 3.3 Add `given/jsonata_dict_output_sm_created.py` step (SDK + core integration)
- [ ] 3.4 Wire new step into `given/__init__.py` (SDK + core integration)

## 4. Quality

- [ ] 4.1 Run `make check` in `lang/python/core` and `lang/python/sdk` and fix all issues
