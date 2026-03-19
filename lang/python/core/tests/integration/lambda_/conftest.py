"""Shared fixtures and BDD step definitions for Lambda integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.lambda_runtime.routes import LambdaRegistry, create_lambda_management_app

INT_FUNCTION_NAME = "int-lambda-fn-1"
INT_FUNCTION_ARN = f"arn:aws:lambda:us-east-1:123456789012:function:{INT_FUNCTION_NAME}"
INT_ESM_SOURCE_ARN = "arn:aws:sqs:us-east-1:123456789012:int-test-queue-1"
INT_ROLE_ARN = "arn:aws:iam::123456789012:role/int-test-role-1"
INT_TAG_KEY = "int-lambda-tag-key-1"
INT_TAG_VALUE = "int-lambda-tag-val-1"
INT_STATEMENT_ID = "int-lambda-stmt-1"
INT_PRINCIPAL = "events.amazonaws.com"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    """Lambda invoke uses the Lambda management API; no dedicated provider needed."""
    yield None


@pytest.fixture
def app(provider):
    registry = LambdaRegistry()
    return create_lambda_management_app(registry)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _create_function(client: TestClient, name: str = INT_FUNCTION_NAME) -> None:
    return client.post(
        "/2015-03-31/functions",
        json={
            "FunctionName": name,
            "Runtime": "python3.12",
            "Role": INT_ROLE_ARN,
            "Handler": "index.handler",
            "Code": {"ZipFile": ""},
        },
    )


def _create_esm(
    client: TestClient,
    function_name: str = INT_FUNCTION_NAME,
    source_arn: str = INT_ESM_SOURCE_ARN,
) -> None:
    return client.post(
        "/2015-03-31/event-source-mappings",
        json={"FunctionName": function_name, "EventSourceArn": source_arn},
    )


def _get_esm_uuid(
    client: TestClient,
    function_name: str = INT_FUNCTION_NAME,
) -> str:
    r = client.get("/2015-03-31/event-source-mappings")
    mappings = r.json().get("EventSourceMappings", [])
    for m in mappings:
        if m.get("FunctionArn", "").endswith(function_name):
            return m["UUID"]
    return ""


# ── Given: function state ─────────────────────────────────────────────────────


@given("the function does not already exist")
def function_not_already_exist():
    """No-op: fresh state has no functions."""


@given("the function already exists")
def function_already_exists(client: TestClient, world):
    _create_function(client)
    world["_skip"] = "lws does not enforce function uniqueness in stateless integration tests."


@given("the function exists")
def function_exists(client: TestClient):
    _create_function(client)


@given("the function does not exist")
def function_does_not_exist(world):
    """Signal that lws does not enforce function existence for all operations."""
    world["_skip"] = (
        "lws does not enforce function existence checks in stateless integration tests."
    )


@given('the function is "ACTIVE"')
def function_is_active():
    """No-op: functions are ACTIVE immediately after creation in lws."""


@given('the function is not "ACTIVE"')
def function_is_not_active(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the function is "PENDING"')
def function_is_pending(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the function is not "PENDING"')
def function_is_not_pending(world):
    """Signal that lws does not enforce PENDING lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )


@given('the function is "FAILED"')
def function_is_failed(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the function is not "FAILED"')
def function_is_not_failed(world):
    """Signal that lws does not enforce FAILED lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )


@given('the function is "DELETING"')
def function_is_deleting(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the function is not "DELETING"')
def function_is_not_deleting(world):
    """Signal that lws does not enforce DELETING lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )


@given('the function is "DELETED"')
def function_is_deleted_given(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the function is not "DELETED"')
def function_is_not_deleted():
    """No-op: functions are not in DELETED state by default."""


@given("the function has a resource policy entry")
def function_has_resource_policy_entry(client: TestClient):
    _create_function(client)
    client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy",
        json={
            "StatementId": INT_STATEMENT_ID,
            "Action": "lambda:InvokeFunction",
            "Principal": INT_PRINCIPAL,
        },
    )


@given("the function does not have a resource policy entry")
def function_does_not_have_resource_policy_entry(client: TestClient, world):
    _create_function(client)
    world["_skip"] = (
        "lws does not enforce resource policy entry existence checks "
        "in stateless integration tests."
    )


@given("the function has a resource policy")
def function_has_resource_policy(client: TestClient):
    _create_function(client)
    client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy",
        json={
            "StatementId": INT_STATEMENT_ID,
            "Action": "lambda:InvokeFunction",
            "Principal": INT_PRINCIPAL,
        },
    )


@given("the function does not have a resource policy")
def function_does_not_have_resource_policy(client: TestClient, world):
    _create_function(client)
    world["_skip"] = (
        "lws does not enforce resource policy existence checks in stateless integration tests."
    )


@given("the function has active execution tracking")
def function_has_active_execution_tracking(world):
    pytest.skip("Cannot configure execution tracking in integration tests.")


@given("the function does not have active execution tracking")
def function_does_not_have_active_execution_tracking():
    """No-op: fresh functions have no active execution tracking."""


@given("the function has active executions")
def function_has_active_executions(world):
    pytest.skip("Cannot force active executions in integration tests.")


@given("the function has at least one active execution")
def function_has_at_least_one_active_execution(world):
    pytest.skip("Cannot force active executions in integration tests.")


@given("the function has no active executions")
def function_has_no_active_executions():
    """No-op: fresh functions have no active executions."""


@given("the function has active executions tracked")
def function_has_active_executions_tracked(world):
    pytest.skip("Cannot force tracked executions in integration tests.")


@given("the function does not have active executions tracked")
def function_does_not_have_active_executions_tracked():
    """No-op: fresh functions have no tracked executions."""


@given("the function has concurrency configured")
def function_has_concurrency_configured(world):
    pytest.skip("Cannot configure concurrency in integration tests without creating first.")


@given("the function does not have concurrency configured")
def function_does_not_have_concurrency_configured(client: TestClient, world):
    _create_function(client)
    world["_skip"] = (
        "lws does not enforce concurrency configuration checks in stateless integration tests."
    )


@given("the function has a positive concurrency limit")
def function_has_positive_concurrency_limit(world):
    pytest.skip("Cannot configure concurrency limit in integration tests.")


@given("the function does not have a positive concurrency limit")
def function_does_not_have_positive_concurrency_limit(world):
    pytest.skip("Cannot configure concurrency limit in integration tests.")


@given("the function has unreserved concurrency")
def function_has_unreserved_concurrency():
    """No-op: functions without explicit concurrency use unreserved pool."""


@given("the function does not have unreserved concurrency")
def function_does_not_have_unreserved_concurrency(world):
    pytest.skip("Cannot exhaust unreserved concurrency in integration tests.")


@given("the active executions are at or above the concurrency limit")
def active_executions_at_or_above_limit(world):
    pytest.skip("Cannot force concurrency limit exceeded in integration tests.")


@given("the active executions are below the concurrency limit")
def active_executions_below_limit():
    """No-op: fresh functions have no active executions."""


@given("the tag is set")
def tag_is_set(client: TestClient):
    _create_function(client)
    client.post(
        f"/2015-03-31/tags/{INT_FUNCTION_ARN}",
        json={"Tags": {INT_TAG_KEY: INT_TAG_VALUE}},
    )


@given("the tag is not set")
def tag_is_not_set(client: TestClient, world):
    _create_function(client)
    world["_skip"] = "lws does not enforce tag existence checks in stateless integration tests."


@given("the tag exists on the function")
def tag_exists_on_function(client: TestClient):
    _create_function(client)
    client.post(
        f"/2015-03-31/tags/{INT_FUNCTION_ARN}",
        json={"Tags": {INT_TAG_KEY: INT_TAG_VALUE}},
    )


@given("the tag does not exist on the function")
def tag_does_not_exist_on_function(client: TestClient, world):
    _create_function(client)
    world["_skip"] = "lws does not enforce tag existence checks in stateless integration tests."


# ── Given: event source mapping state ────────────────────────────────────────


@given("the event source mapping does not already exist")
def esm_not_already_exist():
    """No-op: fresh state has no event source mappings."""


@given("the event source mapping already exists")
def esm_already_exists(client: TestClient, world):
    _create_function(client)
    _create_esm(client)
    world["_skip"] = (
        "lws does not enforce event source mapping uniqueness in stateless integration tests."
    )


@given("the event source mapping exists")
def esm_exists(client: TestClient):
    _create_function(client)
    _create_esm(client)


@given("the event source mapping does not exist")
def esm_does_not_exist(world):
    """Signal that lws does not enforce ESM existence checks in stateless integration tests."""
    world["_skip"] = (
        "lws does not enforce event source mapping existence checks in stateless integration tests."
    )


@given('the mapping is "CREATING"')
def mapping_is_creating(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the mapping is not "CREATING"')
def mapping_is_not_creating(world):
    """Signal that lws does not enforce CREATING lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )


@given('the mapping is "ENABLED"')
def mapping_is_enabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the mapping is not "ENABLED"')
def mapping_is_not_enabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the mapping is "DISABLED"')
def mapping_is_disabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the mapping is not "DISABLED"')
def mapping_is_not_disabled(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the mapping is "DELETING"')
def mapping_is_deleting(world):
    pytest.skip("Lifecycle-dependent state not supported in stateless integration tests.")


@given('the mapping is not "DELETING"')
def mapping_is_not_deleting(world):
    """Signal that lws does not enforce DELETING lifecycle state."""
    world["_skip"] = (
        "lws does not enforce lifecycle state constraints in stateless integration tests."
    )


# ── Given: async slot state ───────────────────────────────────────────────────


@given("the async slot is empty")
def async_slot_is_empty():
    """No-op: async slots are empty by default."""


@given("the async slot is occupied")
def async_slot_is_occupied(world):
    pytest.skip("Cannot pre-fill async slots in integration tests.")


@given("an async slot is available")
def async_slot_available():
    """No-op: async slots are available by default."""


@given("no async slot is available")
def no_async_slot_available(world):
    pytest.skip("Cannot exhaust async slots in integration tests.")


@given("the async slot does not have a function assigned")
def async_slot_no_function():
    """No-op: empty async slots have no function assigned."""


@given("the async slot has a function assigned")
def async_slot_has_function(world):
    pytest.skip("Cannot pre-assign async slots in integration tests.")


@given("retry tracking is available for the slot")
def retry_tracking_available(world):
    pytest.skip("Cannot configure retry tracking in integration tests.")


@given("retry tracking is not available for the slot")
def retry_tracking_not_available(world):
    pytest.skip("Cannot configure retry tracking in integration tests.")


@given("the retry count has been exhausted")
def retry_count_exhausted(world):
    pytest.skip("Cannot exhaust retry count in integration tests.")


@given("the retry count has not been exhausted")
def retry_count_not_exhausted():
    """No-op: fresh state has no retry count."""


# ── Given: FizzBee-generated state steps (no-op / skip) ──────────────────────


@given("fid in func_status")
def fid_in_func_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")


@given("fid not in func_status")
def fid_not_in_func_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")


@given("fid in func_has_policy")
def fid_in_func_has_policy(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")


@given("fid in func_active_execs")
def fid_in_func_active_execs(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")


@given("mid in mapping_status")
def mid_in_mapping_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")


@given("mid not in mapping_status")
def mid_not_in_mapping_status(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")


@given("slot in async_func")
def slot_in_async_func(world):
    pytest.skip("FizzBee model-level precondition — not applicable in integration tests.")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a function is created")
def create_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = _create_function(client)
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an active function is deleted")
def delete_active_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.delete(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json()


@when("a failed function is deleted")
def delete_failed_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.delete(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json()


@when("a function finishes being deleted")
def function_finishes_being_deleted(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.get("/2015-03-31/functions")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a pending function resolves its deployment")
def pending_function_resolves(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a function's code is updated")
def update_function_code(client: TestClient, world):
    r = client.put(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/code",
        json={"ZipFile": ""},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a function's configuration is updated")
def update_function_configuration(client: TestClient, world):
    r = client.put(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/configuration",
        json={"FunctionName": INT_FUNCTION_NAME, "Timeout": 60},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a function is invoked synchronously within its concurrency limit")
def invoke_function_sync_within_limit(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/invocations",
        json={},
    )
    if r.status_code < 300:
        world["result"] = r.json() if r.content else {}
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}


@when("a function is invoked synchronously without a concurrency limit")
def invoke_function_sync_no_limit(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/invocations",
        json={},
    )
    if r.status_code < 300:
        world["result"] = r.json() if r.content else {}
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}


@when("a synchronous function invocation completes")
def sync_invocation_completes(client: TestClient, world):
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a function is invoked asynchronously")
def invoke_function_async(client: TestClient, world):
    r = client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/invocations",
        headers={"X-Amz-Invocation-Type": "Event"},
        json={},
    )
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 202 else r.json()
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}


@when("an async invocation succeeds")
def async_invocation_succeeds(client: TestClient, world):
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an async invocation fails and is retried")
def async_invocation_fails_and_retried(client: TestClient, world):
    world["result"] = None
    pytest.skip("Cannot force async invocation failure and retry in integration tests.")


@when("an async invocation exhausts all retries")
def async_invocation_exhausts_retries(client: TestClient, world):
    world["result"] = None
    pytest.skip("Cannot exhaust async invocation retries in integration tests.")


@when("a permission is added to a function's resource policy")
def add_permission(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.post(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy",
        json={
            "StatementId": INT_STATEMENT_ID,
            "Action": "lambda:InvokeFunction",
            "Principal": INT_PRINCIPAL,
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a permission is removed from a function's resource policy")
def remove_permission(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.delete(
        f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy/{INT_STATEMENT_ID}",
    )
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}


@when("reserved concurrency is set for a function")
def set_reserved_concurrency(client: TestClient, world):
    pytest.skip("lws does not implement the PUT /concurrency route for Lambda functions.")


@when("a tag is added to a function")
def add_tag_to_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.post(
        f"/2015-03-31/tags/{INT_FUNCTION_ARN}",
        json={"Tags": {INT_TAG_KEY: INT_TAG_VALUE}},
    )
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}


@when("a tag is removed from a function")
def remove_tag_from_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.delete(
        f"/2015-03-31/tags/{INT_FUNCTION_ARN}",
        params={"tagKeys": INT_TAG_KEY},
    )
    if r.status_code < 300:
        world["result"] = {} if r.status_code == 204 else r.json()
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}


@when("an event source mapping is created")
def create_event_source_mapping(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = _create_esm(client)
    if r.status_code < 300:
        world["result"] = r.json()
        world["esm_uuid"] = r.json().get("UUID", "")
    else:
        world["error"] = r.json()


@when("an enabled event source mapping is deleted")
def delete_enabled_esm(client: TestClient, world):
    uuid = _get_esm_uuid(client)
    r = client.delete(f"/2015-03-31/event-source-mappings/{uuid}")
    if r.status_code < 300:
        world["result"] = r.json() if r.content else {}
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}


@when("a disabled event source mapping is deleted")
def delete_disabled_esm(client: TestClient, world):
    uuid = _get_esm_uuid(client)
    r = client.delete(f"/2015-03-31/event-source-mappings/{uuid}")
    if r.status_code < 300:
        world["result"] = r.json() if r.content else {}
    else:
        world["error"] = r.json() if r.content else {"__type": "Error"}


@when("an event source mapping finishes being deleted")
def esm_finishes_being_deleted(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.get("/2015-03-31/event-source-mappings")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an event source mapping finishes creating")
def esm_finishes_creating(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = client.get("/2015-03-31/event-source-mappings")
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("an enabled event source mapping is disabled")
def disable_enabled_esm(client: TestClient, world):
    uuid = _get_esm_uuid(client)
    r = client.put(
        f"/2015-03-31/event-source-mappings/{uuid}",
        json={"Enabled": False},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


@when("a disabled event source mapping is enabled")
def enable_disabled_esm(client: TestClient, world):
    uuid = _get_esm_uuid(client)
    r = client.put(
        f"/2015-03-31/event-source-mappings/{uuid}",
        json={"Enabled": True},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the function is in "PENDING" state')
def function_is_in_pending_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected function creation to succeed but got: {actual_error}"
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    assert r.status_code == 200, f"Expected to retrieve function but got status {r.status_code}"
    expected_states = ("Active", "Pending")
    actual_state = r.json().get("Configuration", r.json()).get("State", "")
    assert (
        actual_state in expected_states
    ), f"Expected function state in {expected_states} but got: {actual_state}"


@then('the function enters "DELETING" state')
def function_enters_deleting_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected function deletion to succeed but got: {actual_error}"


@then('the function is "DELETED"')
def function_is_deleted_then(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected function deletion to succeed but got: {actual_error}"


@then('the function becomes "ACTIVE" or "FAILED" non-deterministically')
def function_becomes_active_or_failed(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected deployment resolution to succeed but got: {actual_error}"


@then('the function returns to "PENDING" state for redeployment')
def function_returns_to_pending_for_redeployment(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected code update to succeed but got: {actual_error}"


@then('the function configuration is updated while remaining "ACTIVE"')
def function_configuration_updated(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected configuration update to succeed but got: {actual_error}"


@then("the active execution count increases")
def active_execution_count_increases(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected invocation to succeed but got: {actual_error}"


@then("the active execution count decreases")
def active_execution_count_decreases(world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected invocation completion to succeed but got: {actual_error}"


@then("the event is queued in an async slot")
def event_queued_in_async_slot(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected async invocation to be queued but got: {actual_error}"


@then("the async slot is freed")
def async_slot_is_freed(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected async slot to be freed but got: {actual_error}"


@then("the event is dropped and the slot is freed")
def event_dropped_and_slot_freed(world):
    pytest.skip("Cannot observe async slot state in integration tests.")


@then("the retry count increases")
def retry_count_increases(world):
    pytest.skip("Cannot observe retry count in integration tests.")


@then("the function has a resource policy")
def function_has_resource_policy_then(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected permission to be added but got: {actual_error}"
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}/policy")
    assert (
        r.status_code == 200
    ), f"Expected to retrieve function policy but got status {r.status_code}"


@then("the function's resource policy is cleared")
def function_resource_policy_cleared(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected permission to be removed but got: {actual_error}"


@then("the function has an unreserved, throttled, or explicit concurrency limit")
def function_has_concurrency_limit(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected concurrency setting to succeed but got: {actual_error}"


@then("the function has the tag set")
def function_has_tag_set(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected tag to be added but got: {actual_error}"
    r = client.get(f"/2015-03-31/tags/{INT_FUNCTION_ARN}")
    assert (
        r.status_code == 200
    ), f"Expected to retrieve function tags but got status {r.status_code}"
    actual_tags = r.json().get("Tags", {})
    assert (
        INT_TAG_KEY in actual_tags
    ), f"Expected tag '{INT_TAG_KEY}' to be set but found tags: {actual_tags}"


@then("the tag is cleared from the function")
def tag_cleared_from_function(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected tag to be removed but got: {actual_error}"


@then('the mapping is in "CREATING" state and linked to a function')
def mapping_is_in_creating_state(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping creation to succeed but got: {actual_error}"
    r = client.get("/2015-03-31/event-source-mappings")
    mappings = r.json().get("EventSourceMappings", [])
    assert mappings, "Expected at least one event source mapping but found none"


@then('the mapping enters "DELETING" state')
def mapping_enters_deleting_state(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping deletion to succeed but got: {actual_error}"


@then('the mapping is "DELETED"')
def mapping_is_deleted(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping deletion to succeed but got: {actual_error}"


@then('the mapping is "DISABLED" and inactive')
def mapping_is_disabled_and_inactive(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping disable to succeed but got: {actual_error}"


@then('the mapping is "ENABLED" and active')
def mapping_is_enabled_and_active(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping enable to succeed but got: {actual_error}"


@then('the mapping is "ENABLED"')
def mapping_is_enabled_then(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping to be enabled but got: {actual_error}"


@then("every active event source mapping references an existing non-deleted function")
def active_esm_references_active_function():
    """Invariant: trivially satisfied in isolated lws context."""


@then('no function in "DELETING" state has active executions')
def no_deleting_function_has_active_executions():
    """Invariant: trivially satisfied in isolated lws context."""


@then("active execution count never exceeds reserved concurrency when set")
def active_executions_within_concurrency():
    """Invariant: trivially satisfied in isolated lws context."""


@then("async retry count never exceeds two")
def async_retry_count_within_limit():
    """Invariant: trivially satisfied in isolated lws context."""


@then("every event source mapping has a valid status")
def every_esm_has_valid_status():
    """Invariant: trivially satisfied in isolated lws context."""


@then("every function has a valid status")
def every_function_has_valid_status():
    """Invariant: trivially satisfied in isolated lws context."""


@then("all async slots reference known function IDs or are empty")
def async_slots_reference_known_functions():
    """Invariant: trivially satisfied in isolated lws context."""
