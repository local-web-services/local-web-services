"""Abstract BDD step definitions for LambdaLambda integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_CALLER = "e2e-test-caller-1"
TEST_CALLEE = "e2e-test-callee-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _create_function(lws_session, name):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


# ── Given: caller function state ──────────────────────────────────────


@given("the caller function does not already exist")
def caller_func_not_already_exist():
    """No-op: fresh state has no functions."""


@given("the caller function already exists")
def caller_func_already_exists(lws_session):
    _create_function(lws_session, TEST_CALLER)


@given("the caller exists")
def caller_exists(lws_session):
    _create_function(lws_session, TEST_CALLER)


@given('the caller is "ACTIVE"')
def caller_is_active_given():
    """No-op: functions are ACTIVE immediately after creation."""


@given('the caller is not "ACTIVE"')
def caller_is_not_active_given(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_CALLER)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").create_dwell_ms(5000).apply()
    _create_function(lws_session, TEST_CALLER)
    world["result"] = None
    world["error"] = None


@given("the caller does not exist")
def caller_does_not_exist():
    """No-op: fresh state has no functions."""


# ── Given: callee function state ──────────────────────────────────────


@given("the callee function does not already exist")
def callee_func_not_already_exist():
    """No-op: fresh state has no functions."""


@given("the callee function already exists")
def callee_func_already_exists(lws_session):
    _create_function(lws_session, TEST_CALLEE)


@given("the callee exists")
def callee_exists(lws_session):
    _create_function(lws_session, TEST_CALLEE)


@given('the callee is "ACTIVE"')
def callee_is_active_given(lws_session):
    try:
        _create_function(lws_session, TEST_CALLEE)
    except Exception:  # noqa: BLE001
        pass


@given('the callee is already "DELETED"')
def callee_is_already_deleted(lws_session, world):
    try:
        _create_function(lws_session, TEST_CALLEE)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("lambda").delete_dwell_ms(5000).apply()
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_CALLEE)
    except Exception:  # noqa: BLE001
        pass
    world["result"] = None
    world["error"] = None


@given("the callee does not exist")
def callee_does_not_exist():
    """No-op: fresh state has no functions."""


@given('the callee does not exist or is "DELETED"')
def callee_not_exist_or_deleted():
    """No-op: fresh state has no functions."""


@given('the callee is "DELETED"')
def callee_is_deleted_given():
    """No-op: fresh state has no functions (simulates deleted callee)."""


@given('the callee is not "DELETED"')
def callee_is_not_deleted_given(lws_session):
    _create_function(lws_session, TEST_CALLEE)


# ── Given: invocation state ────────────────────────────────────────────


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress(lws_session):
    _create_function(lws_session, TEST_CALLER)


@given('no invocation is "IN_PROGRESS"')
def no_invocation_is_in_progress():
    """No-op: fresh state has no invocations."""


@given("an invocation slot is available")
def invocation_slot_available():
    """No-op: always room for invocations."""


@given("no invocation slot is available")
def no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")


# ── When: actions ───────────────────────────────────────────────────────


@when("a caller Lambda function is deployed")
def deploy_caller(lws_session, world):
    try:
        _create_function(lws_session, TEST_CALLER)
        world["result"] = {"FunctionName": TEST_CALLER}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a callee Lambda function is deployed")
def deploy_callee(lws_session, world):
    try:
        _create_function(lws_session, TEST_CALLEE)
        world["result"] = {"FunctionName": TEST_CALLEE}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the callee Lambda function is deleted")
def delete_callee(lws_session, world):
    try:
        _lambda(lws_session).delete_function(FunctionName=TEST_CALLEE)
        world["result"] = {"FunctionName": TEST_CALLEE}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the caller Lambda function is invoked")
def invoke_caller(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the caller fails to invoke the callee because the callee has been deleted")
def caller_invocation_fails_callee_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the caller Lambda function invokes the "ACTIVE" callee and the call succeeds')
def caller_invokes_callee_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the caller function is "ACTIVE"')
def caller_func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_CALLER)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected caller function state '{expected_state}' but got '{actual_state}'"


@then('the callee function is "ACTIVE"')
def callee_func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_CALLEE)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected callee function state '{expected_state}' but got '{actual_state}'"


@then('the callee is "DELETED" and invocations targeting it will fail')
def callee_is_deleted_then(lws_session):
    try:
        _lambda(lws_session).get_function(FunctionName=TEST_CALLEE)
        raise AssertionError(f"Expected callee '{TEST_CALLEE}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_codes = ("ResourceNotFoundException", "404")
        assert (
            error_code in expected_codes
        ), f"Expected 'ResourceNotFoundException' but got: {error_code}"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a ResourceNotFoundException')
def invocation_failed_resource_not_found(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")
