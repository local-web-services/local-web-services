## 1. Assign field

- [ ] 1.1 Add `assign` field to all state dataclasses in `asl_parser.py`
- [ ] 1.2 Parse `Assign` in all state parser functions in `asl_parser.py`
- [ ] 1.3 Add `evaluate_assign` helper to `jsonata_evaluator.py`
- [ ] 1.4 Update `evaluate_expression` to bind `$states.context.variables`
- [ ] 1.5 Thread `variables` dict through the engine execution loop
- [ ] 1.6 Apply `Assign` after each state output in engine helpers
- [ ] 1.7 Unit tests for `evaluate_assign` and variable propagation

## 2. Choice.Condition

- [ ] 2.1 Add `condition` field to `ChoiceRule` dataclass in `asl_parser.py`
- [ ] 2.2 Add `query_language` field to `ChoiceState` dataclass
- [ ] 2.3 Parse `Condition` in `_parse_choice_rule` in `asl_parser.py`
- [ ] 2.4 Parse `QueryLanguage` in `_parse_choice_state` in `asl_parser.py`
- [ ] 2.5 Add `evaluate_condition` helper to `jsonata_evaluator.py`
- [ ] 2.6 Update `evaluate_rule` in `choice_evaluator.py` to dispatch on `Condition`
- [ ] 2.7 Update `_execute_choice` in engine to pass JSONata mode context
- [ ] 2.8 Unit tests for JSONata Choice.Condition evaluation

## 3. Credentials

- [ ] 3.1 Add `credentials` field to `TaskState` dataclass in `asl_parser.py`
- [ ] 3.2 Parse `Credentials` dict in `_parse_task_state` in `asl_parser.py`
- [ ] 3.3 Add `resolve_credentials` helper to `jsonata_evaluator.py`
- [ ] 3.4 Evaluate `Credentials.RoleArn` expression before task invocation in engine
- [ ] 3.5 Unit tests for dynamic credentials resolution

## 4. Quality

- [ ] 4.1 Run `make check` in `lang/python/core` and fix all issues
