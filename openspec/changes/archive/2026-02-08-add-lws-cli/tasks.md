## 1. Management API
- [x] 1.1 Add `GET /_ldk/resources` endpoint to `src/lws/api/management.py`
- [x] 1.2 Pass resource metadata (ports, names, ARNs) to the management router

## 2. Shared Client
- [x] 2.1 Create `src/lws/cli/services/__init__.py`
- [x] 2.2 Create `src/lws/cli/services/client.py` with `LwsClient` class

## 3. Entry Point
- [x] 3.1 Create `src/lws/cli/lws.py` with Typer app registering all service sub-apps
- [x] 3.2 Add `lws = "ldk.cli.lws:app"` entry point to `pyproject.toml`
- [x] 3.3 Add `httpx` to main dependencies in `pyproject.toml`

## 4. Service Commands
- [x] 4.1 Create `src/lws/cli/services/stepfunctions.py` (start-execution, describe-execution, list-executions, list-state-machines)
- [x] 4.2 Create `src/lws/cli/services/sqs.py` (send-message, receive-message, delete-message, get-queue-attributes)
- [x] 4.3 Create `src/lws/cli/services/sns.py` (publish, list-topics, list-subscriptions)
- [x] 4.4 Create `src/lws/cli/services/s3.py` (put-object, get-object, delete-object, list-objects-v2, head-object)
- [x] 4.5 Create `src/lws/cli/services/dynamodb.py` (put-item, get-item, delete-item, scan, query)
- [x] 4.6 Create `src/lws/cli/services/events.py` (put-events, list-rules)
- [x] 4.7 Create `src/lws/cli/services/cognito.py` (sign-up, confirm-sign-up, initiate-auth)

## 5. Tests
- [x] 5.1 Create `tests/unit/api/test_management_resources.py`
- [x] 5.2 Create `tests/unit/cli/services/test_client_*.py` (split per architecture constraint)
- [x] 5.3 Create `tests/unit/cli/test_lws.py`
- [x] 5.4 Create tests for each service command module
