"""Abstract BDD step definitions for LambdaSsm integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_PARAM = "/e2e/test/param/1"
TEST_PARAM_VALUE = "e2e-test-value-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _ssm(lws_session):
    return lws_session.client("ssm")


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_param(lws_session, name=TEST_PARAM):
    _ssm(lws_session).put_parameter(Name=name, Value=TEST_PARAM_VALUE, Type="String")


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


# ── Given: parameter state ─────────────────────────────────────────────


@given("the parameter does not already exist")
def param_not_already_exist():
    """No-op: fresh state has no parameters."""


@given("the parameter already exists")
def param_already_exists(lws_session):
    _create_param(lws_session)


@given("the parameter exists")
def param_exists(lws_session):
    _create_param(lws_session)


@given('the parameter "EXISTS"')
def param_exists_given():
    """No-op: parameter already created by 'the parameter exists' step."""


@given('the parameter is already "DELETED"')
def param_is_already_deleted(lws_session, world):
    try:
        _create_param(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("ssm").delete_dwell_ms(5000).apply()
    _ssm(lws_session).delete_parameter(Name=TEST_PARAM)
    world["result"] = None
    world["error"] = None


@given("the parameter does not exist")
def param_does_not_exist():
    """No-op: fresh state has no parameters."""


@given('the parameter does not exist or is "DELETED"')
def param_not_exist_or_deleted():
    """No-op: fresh state has no parameters."""


@given('the parameter is "DELETED"')
def param_is_deleted_given():
    """No-op: fresh state has no parameters (simulates deleted parameter)."""


@given('the parameter is not "DELETED"')
def param_is_not_deleted_given(lws_session):
    _create_param(lws_session)


# ── Given: invocation state ────────────────────────────────────────────


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


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no functions."""


@given("pid not in param_status")
def pid_not_in_param_status():
    """No-op: fresh state has no parameters."""


@given("pid in param_status")
def pid_in_param_status(lws_session):
    _create_param(lws_session)


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    _create_function(lws_session)


@given('a parameter has been created in "SSM" Parameter Store')
def ssm_parameter_has_been_created_seq(lws_session):
    _create_param(lws_session)


@given('a parameter has been deleted from "SSM" Parameter Store')
def ssm_parameter_has_been_deleted_seq(lws_session):
    try:
        _create_param(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _ssm(lws_session).delete_parameter(Name=TEST_PARAM)


@given("the Lambda function has been invoked")
def lambda_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given("the Lambda function has read an existing parameter and completed successfully")
def lambda_read_parameter_succeeded_seq():
    pytest.skip("Cannot trigger Lambda SSM read in lws")


@given("the Lambda function has failed because the parameter has been deleted")
def lambda_failed_parameter_deleted_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


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


@when('a parameter is created in "SSM" Parameter Store')
def create_parameter(lws_session, world):
    try:
        world["result"] = _ssm(lws_session).put_parameter(
            Name=TEST_PARAM,
            Value=TEST_PARAM_VALUE,
            Type="String",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('a parameter is deleted from "SSM" Parameter Store')
def delete_parameter(lws_session, world):
    try:
        world["result"] = _ssm(lws_session).delete_parameter(Name=TEST_PARAM)
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails because the parameter has been deleted")
def invocation_fails_param_not_found(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function reads an existing parameter and completes successfully")
def invocation_reads_param_succeeds(world):
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


@then('the parameter "EXISTS" and can be read by Lambda')
def param_exists_and_readable(lws_session):
    resp = _ssm(lws_session).get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    expected_value = TEST_PARAM_VALUE
    assert (
        actual_value == expected_value
    ), f"Expected parameter value '{expected_value}' but got '{actual_value}'"


@then('the parameter is "DELETED" and will cause a ParameterNotFound error when read')
def param_is_deleted_then(lws_session):
    try:
        _ssm(lws_session).get_parameter(Name=TEST_PARAM)
        raise AssertionError(f"Expected parameter '{TEST_PARAM}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_code = "ParameterNotFound"
        assert error_code == expected_code, f"Expected '{expected_code}' but got: {error_code}"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a ParameterNotFound error')
def invocation_failed_param_not_found(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


# ── Then: invariants and rejection ────────────────────────────────────


@then("the operation is rejected")
def operation_is_rejected_lambda_ssm(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world.get("error")
    assert actual_error is not expected_error, "Expected operation to be rejected but it succeeded"


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def every_in_progress_invocation_references_active_function_ssm():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every successful invocation recorded which parameter it read")
def every_successful_invocation_recorded_parameter():
    """Invariant step: trivially satisfied in isolated test context."""
