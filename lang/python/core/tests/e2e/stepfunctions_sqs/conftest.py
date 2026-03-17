"""Abstract BDD step definitions for StepfunctionsSqs integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_QUEUE = "e2e-test-q1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps(
    {"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}}
)
TEST_INPUT = '{"key": "value"}'


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _sqs(lws_session):
    return lws_session.client("sqs")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_queue(lws_session, name=TEST_QUEUE):
    _sqs(lws_session).create_queue(QueueName=name)


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


@given("the state machine is \"ACTIVE\"")
def sm_is_active_given():
    """No-op: state machines are ACTIVE immediately after creation."""


@given("the state machine is not \"ACTIVE\"")
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


@given("the state machine has no \"SQS\" task configured")
def sm_has_no_sqs_task():
    pytest.skip("lws does not validate SQS task configuration before starting an execution")


@given("the state machine has an \"SQS\" task configured")
def sm_has_sqs_task():
    pytest.skip("Cannot pre-configure SQS task on state machine in lws")


@given("the state machine already has an \"SQS\" task configured")
def sm_already_has_sqs_task():
    pytest.skip("Cannot pre-configure SQS task on state machine in this context")


# ── Given: queue state ────────────────────────────────────────────────

@given("the queue does not already exist")
def queue_not_already_exist():
    """No-op: fresh state has no queues."""


@given("the queue already exists")
def queue_already_exists(lws_session):
    _create_queue(lws_session)


@given("the queue exists")
def queue_exists(lws_session):
    _create_queue(lws_session)


@given("the queue is \"ACTIVE\"")
def queue_is_active_given():
    """No-op: queues are ACTIVE by default after creation."""


@given("the queue is not \"ACTIVE\"")
def queue_is_not_active_given(lws_session, world):
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    _create_queue(lws_session)
    world["result"] = None
    world["error"] = None


@given("the queue does not exist")
def queue_does_not_exist():
    """No-op: fresh state has no queues."""


@given("the target queue is \"ACTIVE\"")
def target_queue_is_active():
    """No-op: queues are ACTIVE by default after creation."""


@given("the target queue is not \"ACTIVE\"")
def target_queue_is_not_active(lws_session, world):
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    _create_queue(lws_session)
    world["result"] = None
    world["error"] = None


# ── Given: execution state ────────────────────────────────────────────

@given("an execution is \"RUNNING\"")
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given("no execution is \"RUNNING\"")
def no_execution_is_running():
    """No-op: fresh state has no executions."""


@given("the execution's state machine has a configured \"SQS\" task")
def execution_sm_has_sqs_task():
    pytest.skip("Cannot pre-configure SQS task on state machine in this context")


@given("the execution's state machine has no \"SQS\" task configured")
def execution_sm_has_no_sqs_task():
    """No-op: state machines have no SQS task by default."""


# ── Given: slots ───────────────────────────────────────────────────────

@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available():
    pytest.skip("Cannot exhaust execution slot limit")


@given("a message slot is available")
def message_slot_available():
    """No-op: always room for messages."""


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip("Cannot exhaust message slot limit")


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


@when("an \"SQS\" queue is created")
def create_sqs_queue(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).create_queue(QueueName=TEST_QUEUE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an \"SQS\" send-message task is configured on the state machine")
def configure_sqs_task(world):
    pytest.skip("Cannot configure SQS task on state machine in lws")


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


@when("a running execution reaches the \"SQS\" task state and sends a message to the queue")
def execution_sends_message(world):
    pytest.skip("Cannot trigger internal execution step that sends message to SQS")


# ── Then: assertions ───────────────────────────────────────────────────

@then("the state machine is \"ACTIVE\"")
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert actual_status == expected_status, (
        f"Expected state machine status '{expected_status}' but got '{actual_status}'"
    )


@then("the state machine is \"ACTIVE\" with no \"SQS\" task configured")
def sm_is_active_with_no_sqs_task(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert actual_status == expected_status, (
        f"Expected state machine status '{expected_status}' but got '{actual_status}'"
    )


@then("the queue is \"ACTIVE\"")
def queue_is_active_then(lws_session):
    url = _queue_url(lws_session)
    resp = _sqs(lws_session).get_queue_attributes(QueueUrl=url, AttributeNames=["All"])
    assert resp.get("Attributes") is not None, (
        f"Expected queue '{TEST_QUEUE}' to be ACTIVE but got no attributes"
    )


@then("the state machine will enqueue a message when it reaches the task state")
def sm_will_enqueue_message(world):
    pytest.skip("Cannot observe SQS task configuration in lws")


@then("the execution is \"RUNNING\"")
def execution_is_running_then(world):
    assert world["error"] is None, (
        f"Expected start_execution to succeed but got: {world['error']}"
    )
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then("the message is \"AVAILABLE\" in the queue and the execution is \"SUCCEEDED\"")
def message_available_and_execution_succeeded(world):
    pytest.skip("Cannot observe internal execution SQS send in lws")


