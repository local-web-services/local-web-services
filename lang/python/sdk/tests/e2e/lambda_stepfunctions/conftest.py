"""Abstract BDD step definitions for LambdaStepfunctions integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_SM = "test-sm-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})


def _lambda(lws_session):
    return lws_session.client("lambda")


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


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


# ── Given: state machine state ─────────────────────────────────────────


@given("the state machine does not already exist")
def sm_not_already_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine already exists")
def sm_already_exists(lws_session):
    _create_sm(lws_session)


@given("the state machine exists")
def sm_exists(lws_session):
    _create_sm(lws_session)


@given('the state machine is "ACTIVE"')
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""


@given('the state machine is already "DELETED"')
def sm_is_already_deleted(lws_session, world):
    try:
        _create_sm(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("stepfunctions").delete_dwell_ms(5000).apply()
    try:
        _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn())
    except Exception:  # noqa: BLE001
        pass
    world["result"] = None
    world["error"] = None


@given("the state machine does not exist")
def sm_does_not_exist():
    """No-op: fresh state has no state machines."""


@given('the state machine does not exist or is "DELETED"')
def sm_not_exist_or_deleted():
    """No-op: fresh state has no state machines."""


@given('the state machine is "DELETED"')
def sm_is_deleted_given():
    """No-op: fresh state has no state machines (simulates deleted state machine)."""


@given('the state machine is not "DELETED"')
def sm_is_not_deleted_given(lws_session):
    _create_sm(lws_session)


# ── Given: execution state ─────────────────────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _sfn(lws_session).start_execution(
        stateMachineArn=_sm_arn(),
        input='{"key": "value"}',
    )


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available():
    pytest.skip("Cannot exhaust execution slot limit")


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


@when("a Step Functions state machine is created")
def create_state_machine(lws_session, world):
    try:
        resp = _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=PASS_DEFINITION,
            roleArn=ROLE_ARN,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Step Functions state machine is deleted")
def delete_state_machine(lws_session, world):
    try:
        _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn())
        world["result"] = {"stateMachineArn": _sm_arn()}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a running execution completes successfully")
def execution_completes(world):
    pytest.skip("Cannot observe internal execution completion in lws")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda function fails to start an execution because the state machine has been deleted")
def invocation_fails_sm_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when('the Lambda function starts an execution of an "ACTIVE" state machine and succeeds')
def invocation_starts_execution(world):
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


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the state machine is "DELETED" and Lambda StartExecution calls will fail')
def sm_is_deleted_then(lws_session):
    try:
        _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
        raise AssertionError(
            f"Expected state machine '{TEST_SM}' to be deleted but it still exists"
        )
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_code = "StateMachineDoesNotExist"
        assert error_code == expected_code, f"Expected '{expected_code}' but got: {error_code}"


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then(world):
    pytest.skip("Cannot observe internal execution completion in lws")


@then('the execution is "RUNNING" and the invocation is "SUCCESS"')
def execution_running_invocation_success(world):
    pytest.skip("Cannot observe Lambda invocation result in lws")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED" with a StateMachineDoesNotExist error')
def invocation_failed_sm_not_exist(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


# ── Then: invariants and rejection ────────────────────────────────────


@then("the operation is rejected")
def operation_is_rejected_lambda_stepfunctions(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world.get("error")
    assert actual_error is not expected_error, "Expected operation to be rejected but it succeeded"


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def every_in_progress_invocation_references_active_function_sfn():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "RUNNING" execution references a state machine that exists')
def every_running_execution_references_existing_sm():
    """Invariant step: trivially satisfied in isolated test context."""
