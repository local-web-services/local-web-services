## 1. Core — JSONata evaluator
- [ ] 1.1 Add `jsonata-python` dependency to `lang/python/core/pyproject.toml`
- [ ] 1.2 Create `lang/python/core/src/lws/providers/stepfunctions/jsonata_evaluator.py`

## 2. Core — ASL parser
- [ ] 2.1 Add `query_language` field to `StateMachineDefinition` dataclass
- [ ] 2.2 Add `query_language`, `arguments`, and `output` fields to `PassState`, `TaskState`, `MapState`, `ParallelState`
- [ ] 2.3 Update `_parse_state_machine_dict` to read `QueryLanguage`
- [ ] 2.4 Update `_parse_pass_state`, `_parse_task_state`, `_parse_map_state`, `_parse_parallel_state` to read per-state fields

## 3. Core — Engine
- [ ] 3.1 Add `_is_jsonata_mode`, `_prepare_jsonata_pass_input`, `_apply_jsonata_pass_output`, `_prepare_jsonata_task_input`, `_apply_jsonata_task_output` helpers to `_engine_helpers.py`
- [ ] 3.2 Update `_execute_pass` in `engine.py` to dispatch to JSONata mode when active
- [ ] 3.3 Update `_execute_task` in `engine.py` to dispatch to JSONata mode when active

## 4. Unit tests
- [ ] 4.1 Create `lang/python/core/tests/unit/providers/test_stepfunctions_jsonata_evaluator_basic.py`
- [ ] 4.2 Create `lang/python/core/tests/unit/providers/test_stepfunctions_engine_jsonata_pass_state.py`

## 5. E2E acceptance tests
- [ ] 5.1 Add `JSONATA_SM` constant and `JSONATA_PASS_DEFINITION` to `constants.py`
- [ ] 5.2 Add `create_jsonata_sm()` to `client.py`
- [ ] 5.3 Create `given/jsonata_sm_created.py` step
- [ ] 5.4 Create `then/sync_execution_output_contains_key.py` step
- [ ] 5.5 Update `given/__init__.py` and `then/__init__.py`
- [ ] 5.6 Create `lang/specification/core/informal/stepfunctions/jsonata_expression.feature`
