## 0. Reference guide

- [ ] 0.1 Create `contributing/ADDING_A_SERVICE.md` capturing the end-to-end pattern for
        adding a new emulated service (port allocation, formal spec, informal spec,
        Python provider, Go provider, TypeScript provider, Java provider, CLI, tests,
        SDK redirection, registration)

## 1. Formal specification

- [ ] 1.1 Create `lang/specification/core/formal/cloudtrail/cloudtrail.fizz`
        modelling trail lifecycle, logging state, event recording, and event lookup
- [ ] 1.2 Verify the spec runs: `fizz lang/specification/core/formal/cloudtrail/cloudtrail.fizz`
- [ ] 1.3 Generate Gherkin from the formal spec:
        `python tools/fizz_to_gherkin.py lang/specification/core/formal/cloudtrail/cloudtrail.fizz`
- [ ] 1.4 Save generated Gherkin to `lang/specification/core/informal/cloudtrail/`

## 2. Python provider

- [ ] 2.1 Create `lang/python/core/src/lws/providers/cloudtrail/_cloudtrail_state.py`
        with `_Trail`, `_EventSelector`, `_CloudTrailEvent`, and `_CloudTrailState` dataclasses
- [ ] 2.2 Create `lang/python/core/src/lws/providers/cloudtrail/routes.py`
        with action handlers: `CreateTrail`, `DeleteTrail`, `DescribeTrails`, `GetTrail`,
        `GetTrailStatus`, `StartLogging`, `StopLogging`, `PutEventSelectors`,
        `GetEventSelectors`, `LookupEvents`
- [ ] 2.3 Create `lang/python/core/src/lws/providers/cloudtrail/__init__.py`
        exporting `create_cloudtrail_app`
- [ ] 2.4 Register the provider in the orchestrator / server startup
- [ ] 2.5 Add `AWS_ENDPOINT_URL_CLOUDTRAIL` to `lang/python/core/src/lws/runtime/sdk_env.py`
- [ ] 2.6 Create `lang/python/core/src/lws/cli/services/cloudtrail.py`
        with `lws cloudtrail` sub-commands: `lookup-events`, `create-trail`, `delete-trail`,
        `describe-trails`, `get-trail-status`
- [ ] 2.7 Register CLI commands in `lang/python/core/src/lws/cli/lws.py`
- [ ] 2.8 Write unit tests in `lang/python/core/tests/unit/` for state and action handlers
- [ ] 2.9 Write integration tests in `lang/python/core/tests/integration/` for HTTP wire protocol
- [ ] 2.10 Wire E2E Gherkin in `lang/python/sdk/tests/e2e/cloudtrail/`
          (conftest.py with step definitions, test_scenarios.py)
- [ ] 2.11 Run `make -C lang/python/core check` — all checks pass

## 3. Go provider

- [ ] 3.1 Create `lang/go/core/lws/providers/cloudtrail/handler.go`
        with `Store`, `NewHandler`, and all action dispatch
- [ ] 3.2 Register CloudTrail in `lang/go/core/lws/server.go` at offset 51
- [ ] 3.3 Add CloudTrail port to `ServerPorts` struct and `sdk_env` builder
- [ ] 3.4 Write unit tests in `lang/go/core/tests/cloudtrail_test.go`
- [ ] 3.5 Wire CloudTrail Gherkin paths in `lang/go/sdk/tests/bdd_test.go`
- [ ] 3.6 Run `make -C lang/go check` — all checks pass

## 4. TypeScript provider

- [ ] 4.1 Create `lang/typescript/core/src/providers/cloudtrail/index.ts`
        with action handlers and in-memory state
- [ ] 4.2 Register CloudTrail in the TypeScript server at offset 51
- [ ] 4.3 Add `CLOUDTRAIL` to the TypeScript SDK session ports
- [ ] 4.4 Write tests for the TypeScript provider
- [ ] 4.5 Run `make -C lang/typescript check` — all checks pass

## 5. Java provider

- [ ] 5.1 Create `lang/java/core/src/main/java/io/localwebservices/lws/providers/cloudtrail/CloudTrailStore.java`
- [ ] 5.2 Create `lang/java/core/src/main/java/io/localwebservices/lws/providers/cloudtrail/CloudTrailHandler.java`
- [ ] 5.3 Register CloudTrail in the Java server at offset 51
- [ ] 5.4 Write unit tests under `lang/java/core/src/unitTest/`
- [ ] 5.5 Write BDD step definitions for CloudTrail in `lang/java/core/src/test/java/io/localwebservices/lws/steps/`
- [ ] 5.6 Run `make -C lang/java check` — all checks pass

## 6. Final validation

- [ ] 6.1 Run `make check` at repo root — all languages pass
- [ ] 6.2 Verify `lws cloudtrail lookup-events` returns recorded events in a running `ldk dev` session
