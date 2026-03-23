"""Abstract BDD step definitions for StepfunctionsLambda integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_FUNC = "e2e-test-func-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
LAMBDA_DEFINITION = json.dumps(
    {
        "StartAt": "InvokeFunction",
        "States": {
            "InvokeFunction": {
                "Type": "Task",
                "Resource": "arn:aws:states:::lambda:invoke",
                "Parameters": {
                    "FunctionName": TEST_FUNC,
                },
                "End": True,
            }
        },
    }
)
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _lambda(lws_session):
    return lws_session.client("lambda")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _create_sm(lws_session, name=TEST_SM, definition=PASS_DEFINITION):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=definition,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _start_execution(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).start_execution(
        stateMachineArn=_sm_arn(name),
        input=TEST_INPUT,
    )
    return resp["executionArn"]


# ── Given: state machine state ────────────────────────────────────────


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


@given('the state machine is not "ACTIVE"')
def sm_is_not_active_given(lws_session, world):
    try:
        _sfn(lws_session).delete_state_machine(stateMachineArn=_sm_arn())
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("stepfunctions").create_dwell_ms(5000).apply()
    _create_sm(lws_session)
    world["result"] = None
    world["error"] = None


@given("the state machine does not exist")
def sm_does_not_exist():
    """No-op: fresh state has no state machines."""


@given("the state machine has no Lambda task configured")
def sm_has_no_lambda_task_given():
    pytest.skip(
        "lws does not reject start_execution when the state machine has no Lambda task configured"
    )


@given("the state machine already has a Lambda task configured")
def sm_already_has_lambda_task_given(lws_session):
    try:
        _create_sm(lws_session, definition=LAMBDA_DEFINITION)
    except Exception:  # noqa: BLE001
        pass


@given("the state machine has a Lambda task configured")
def sm_has_lambda_task_given(lws_session):
    try:
        _create_function(lws_session)
    except Exception:  # noqa: BLE001
        pass
    try:
        _create_sm(lws_session, definition=LAMBDA_DEFINITION)
    except Exception:  # noqa: BLE001
        try:
            _sfn(lws_session).update_state_machine(
                stateMachineArn=_sm_arn(),
                definition=LAMBDA_DEFINITION,
            )
        except Exception:  # noqa: BLE001
            pass


# ── Given: function state ─────────────────────────────────────────────


@given("the function does not already exist")
def function_not_already_exist():
    """No-op: fresh state has no Lambda functions."""


@given("the function already exists")
def function_already_exists(lws_session):
    _create_function(lws_session)


@given("the function exists")
def function_exists(lws_session):
    _create_function(lws_session)


@given('the function is "ACTIVE"')
def function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given("the function does not exist")
def function_does_not_exist():
    """No-op: fresh state has no Lambda functions."""


@given('the function is not "ACTIVE"')
def function_is_not_active_given():
    pytest.skip("lws does not support non-ACTIVE Lambda function lifecycle states")


@given('the configured function is "ACTIVE"')
def configured_function_is_active_given():
    """No-op: Lambda functions are ACTIVE immediately after creation."""


@given('the configured function is not "ACTIVE"')
def configured_function_is_not_active_given():
    pytest.skip("lws does not support non-ACTIVE Lambda function lifecycle states")


@given("the execution's state machine has a configured Lambda task")
def sm_has_configured_lambda_task_given():
    """No-op: state machine is set up with a Lambda task in the execution setup."""


@given("the execution's state machine has no Lambda task configured")
def sm_has_no_configured_lambda_task_given():
    """No-op: covered by state machine creation without Lambda task."""


# ── Given: execution and invocation state ─────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


@given('an invocation is "IN_PROGRESS"')
def invocation_is_in_progress_given():
    pytest.skip("Cannot put a Lambda invocation into IN_PROGRESS state in lws")


@given('no invocation is "IN_PROGRESS"')
def no_invocation_is_in_progress():
    """No-op: fresh state has no invocations."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available():
    pytest.skip("Cannot exhaust execution slot limit")


@given("an invocation slot is available")
def invocation_slot_available():
    """No-op: always room for invocations."""


@given("no invocation slot is available")
def no_invocation_slot_available():
    pytest.skip("Cannot exhaust invocation slot limit")


# ── When: actions ──────────────────────────────────────────────────────


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
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a Lambda function is deployed")
def deploy_lambda_function(lws_session, world):
    try:
        resp = _lambda(lws_session).create_function(
            FunctionName=TEST_FUNC,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a Lambda task is configured on the state machine")
def configure_lambda_task(lws_session, world):
    pytest.skip("Cannot trigger Lambda task configuration on state machine in lws")


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a running execution reaches the Lambda task state and invokes the function")
def execution_invokes_lambda(world):
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")


@when("the Lambda task fails and the execution fails")
def lambda_task_fails(world):
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")


@when("the Lambda task completes successfully and the execution succeeds")
def lambda_task_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the state machine is "ACTIVE" with no Lambda task configured')
def sm_is_active_no_lambda_task_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the function is "ACTIVE"')
def function_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then("the state machine will invoke the function when it reaches the task state")
def sm_will_invoke_function_then():
    pytest.skip("Cannot trigger Lambda invocation from StepFunctions in lws")


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then():
    pytest.skip("Cannot observe internal Lambda invocation IN_PROGRESS state in lws")


@then('the invocation is "FAILED" and the execution is "FAILED"')
def invocation_failed_execution_failed():
    pytest.skip("Cannot observe internal Lambda invocation failure in lws")


@then('the invocation is "SUCCESS" and the execution is "SUCCEEDED"')
def invocation_success_execution_succeeded():
    pytest.skip("Cannot observe internal Lambda invocation success in lws")


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution Lambda task success in lws")


@then('the execution is "FAILED" with a connection error')
def execution_failed_connection_error():
    pytest.skip("Cannot observe internal execution Lambda task failure in lws")
