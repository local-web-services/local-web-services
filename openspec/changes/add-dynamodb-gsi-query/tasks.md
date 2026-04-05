## 1. FizzBee Formal Spec

- [x] 1.1 Add `QueryGSI` action to `lang/specification/core/formal/dynamodb/dynamodb.fizz` with guards for table ACTIVE and `gsi_pending == 0` (consistent read)
- [x] 1.2 Add `GsiQueryOnlyWhenTableActive` always-assertion to the spec
- [x] 1.3 Run `fizz lang/specification/core/formal/dynamodb/dynamodb.fizz` and confirm all assertions pass

## 2. Gherkin Feature File

- [x] 2.1 Generate `lang/specification/core/informal/dynamodb/query_gsi.feature` from the FizzBee spec using the project's fizz-to-gherkin generator (or author manually following the generated pattern for existing features)
- [x] 2.2 Ensure the feature file has `@minimal @happy` scenario for the happy path and `@guard @negative` scenarios for each guard

## 3. Unit Tests — Provider Layer

- [x] 3.1 Extend `test_dynamodb_provider_gsi.py` with a test for **sparse index** (items without the GSI partition key attribute are not indexed)
- [x] 3.2 Add a test for **update-then-query**: put item, update the GSI key attribute, confirm the GSI reflects the updated value
- [x] 3.3 Add a test for **GSI with sort key range scan**: two items with same GSI PK but different GSI SK; confirm both returned and result count is correct

## 4. Integration Tests — Wire Protocol

- [x] 4.1 Replace `pytest.skip` in `lang/python/core/tests/integration/dynamodb/given/gsi_exists.py` with a proper `CreateTable` call that includes a `GlobalSecondaryIndexes` definition
- [x] 4.2 Implement `lang/python/core/tests/integration/dynamodb/then/gsi_is_consistent_with_table.py` step so it passes (verify GSI query returns expected items)
- [x] 4.3 Create `lang/python/core/tests/integration/test_dynamodb_gsi.py` with full round-trip test: `CreateTable` (with GSI) → `PutItem` → `Query` with `IndexName` → assert items returned
- [x] 4.4 Add negative test: `Query` with `IndexName` on an item where the GSI key attribute is absent → assert item not returned

## 5. OpenSpec Spec

- [x] 5.1 Write `openspec/changes/add-dynamodb-gsi-query/specs/dynamodb-gsi-query/spec.md` with formal requirements and scenarios

## 6. Validation

- [x] 6.1 Run `make check` in `lang/python/core` — all tests pass
- [x] 6.2 All GSI integration tests pass (no skips on GSI scenarios)
- [x] 6.3 Run `openspec validate add-dynamodb-gsi-query --strict --no-interactive` — no errors
