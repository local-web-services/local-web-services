# Change: Add DynamoDB GSI Table Query Support

## Why

DynamoDB Global Secondary Indexes (GSIs) allow querying items by attributes other than the primary key. The LWS DynamoDB emulator already stores GSI projections in SQLite and routes `Query` requests with `IndexName` to those projections, but the capability has no formal spec, no Gherkin scenario for index-based querying, no FizzBee `QueryGSI` action, and the integration-test steps that touch GSI state are currently skipped with `pytest.skip`. This change closes that gap.

## What Changes

- **FizzBee** (`lang/specification/core/formal/dynamodb/dynamodb.fizz`): Add `QueryGSI` action modelling a query on a GSI index, with guard on table active and GSI consistency; add `GsiQueryOnlyWhenTableActive` invariant.
- **Gherkin feature file** (`lang/specification/core/informal/dynamodb/query_gsi.feature`): Generated from the new FizzBee action; covers happy-path and guard-negative scenarios.
- **Unit tests** (`lang/python/core/tests/unit/providers/test_dynamodb_provider_gsi.py`): Extend to cover items that lack GSI key attributes (sparse index), multi-item result ordering, and update-then-query.
- **Integration tests** — replace `pytest.skip` in `gsi_exists.py` with a working implementation that creates a table with a GSI via the DynamoDB wire protocol; add a new HTTP-level integration test file (`lang/python/core/tests/integration/test_dynamodb_gsi.py`) covering `CreateTable`→`PutItem`→`Query (IndexName)` round-trip.
- **OpenSpec spec** (`openspec/specs/dynamodb-gsi-query/spec.md`): New capability spec capturing the requirements formalised here.

## Impact

- Affected specs: new `dynamodb-gsi-query` capability; touches existing `dynamodb-stream-lambda` only indirectly (no overlap).
- Affected code:
  - `lang/specification/core/formal/dynamodb/dynamodb.fizz` — new `QueryGSI` action + invariant
  - `lang/specification/core/informal/dynamodb/query_gsi.feature` — new file (generated)
  - `lang/python/core/tests/unit/providers/test_dynamodb_provider_gsi.py` — extended
  - `lang/python/core/tests/integration/dynamodb/given/gsi_exists.py` — replace skip
  - `lang/python/core/tests/integration/test_dynamodb_gsi.py` — new file
- Relevant ADRs: none existing; no new ADR required (no novel architectural pattern — extends existing GSI SQLite approach).
