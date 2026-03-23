"""Abstract BDD step definitions for LambdaEvents integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_BUS = "e2e-test-bus-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _events(lws_session):
    return lws_session.client("events")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def func_not_already_exist():
    """No-op: fresh state has no functions."""


@given("the function already exists")
def func_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def func_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def func_is_active_given():
    """No-op: functions are ACTIVE immediately after creation."""


@given('the function is not "ACTIVE"')
def func_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_FUNC)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session)
    world["result"] = None
    world["error"] = None


@given("the function does not exist")
def func_does_not_exist():
    """No-op: fresh state has no functions."""


# ── Given: bus state ────────────────────────────────────────────────────


@given("the bus does not already exist")
def bus_not_already_exist():
    """No-op: fresh state has no event buses."""


@given("the bus already exists")
def bus_already_exists(lws_session):
    _create_bus(lws_session)


@given("the bus exists")
def bus_exists(lws_session):
    _create_bus(lws_session)


@given('the bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: event buses are ACTIVE immediately after creation."""


@given('the bus is already "DELETED"')
def bus_is_already_deleted(lws_session, world):
    try:
        _events(lws_session).delete_event_bus(Name=TEST_BUS)
    except Exception:  # noqa: BLE001
        pass
    world["result"] = None
    world["error"] = None


@given("the bus does not exist")
def bus_does_not_exist():
    """No-op: fresh state has no event buses."""


@given('the bus does not exist or is "DELETED"')
def bus_not_exist_or_deleted():
    """No-op: fresh state has no event buses."""


@given('the bus is "DELETED"')
def bus_is_deleted_given():
    """No-op: fresh state has no event buses (simulates deleted bus)."""


@given('the bus is not "DELETED"')
def bus_is_not_deleted_given(lws_session):
    _create_bus(lws_session)


# ── Given: invocation / slot state ────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    _create_function(lws_session)


@given('no invocation is "IN_PROGRESS"')
def no_invocation_is_in_progress():
    """No-op: fresh state has no invocations."""


@given("an invocation slot is available")
def invocation_slot_available():
    """No-op: always room for invocations."""


@given("no invocation slot is available")
def no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available():
    pytest.skip("Cannot exhaust event slot limit")


# ── When: actions ───────────────────────────────────────────────────────


@when("a Lambda function is deployed")
def deploy_lambda_function(lws_session, world):
    try:
        _create_function(lws_session)
        world["result"] = {"FunctionName": TEST_FUNC}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an EventBridge event bus is created")
def create_event_bus(lws_session, world):
    try:
        _create_bus(lws_session)
        world["result"] = {"EventBusName": TEST_BUS}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the EventBridge event bus is deleted")
def delete_event_bus(lws_session, world):
    try:
        _events(lws_session).delete_event_bus(Name=TEST_BUS)
        world["result"] = {"EventBusName": TEST_BUS}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to publish because the event bus has been deleted")
def invocation_fails_bus_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function publishes an event to the "ACTIVE" event bus and succeeds')
def publish_event_task(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).describe_event_bus(Name=TEST_BUS)
    actual_name = resp.get("Name", "")
    expected_name = TEST_BUS
    assert (
        actual_name == expected_name
    ), f"Expected event bus name '{expected_name}' but got '{actual_name}'"


@then('the bus is "DELETED" and Lambda PutEvents calls targeting it will fail')
def bus_is_deleted_then(lws_session):
    try:
        _events(lws_session).describe_event_bus(Name=TEST_BUS)
        raise AssertionError(f"Expected event bus '{TEST_BUS}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_code = "ResourceNotFoundException"
        assert error_code == expected_code, f"Expected '{expected_code}' but got: {error_code}"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a ResourceNotFoundException')
def invocation_failed_resource_not_found(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the event is "PUBLISHED" and the invocation is "SUCCESS"')
def event_published_invocation_success(world):
    pytest.skip("Cannot observe Lambda invocation result in lws")
