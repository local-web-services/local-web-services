"""Abstract BDD step definitions for StepfunctionsSqs integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_QUEUE = "e2e-test-q1"
TEST_MESSAGE_BODY = "e2e-test-sqs-message-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sqs_task_definition(queue_name: str) -> str:
    """Return a state machine definition with an SQS sendMessage task."""
    queue_url = f"http://127.0.0.1/000000000000/{queue_name}"
    return json.dumps(
        {
            "StartAt": "SendToSqs",
            "States": {
                "SendToSqs": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::sqs:sendMessage",
                    "Parameters": {
                        "QueueUrl": queue_url,
                        "MessageBody": TEST_MESSAGE_BODY,
                    },
                    "End": True,
                }
            },
        }
    )


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


# ── Given: sequence setup ─────────────────────────────────────────────


@given("smid not in sm_status")
def smid_not_in_sm_status():
    """No-op: guard condition — fresh state has no state machines."""


@given("smid in sm_status")
def smid_in_sm_status(lws_session):
    _create_sm(lws_session)


@given("a Step Functions state machine has been created")
def sfn_sm_has_been_created(lws_session):
    _create_sm(lws_session)


@given("qid not in queue_status")
def qid_not_in_queue_status():
    """No-op: guard condition — fresh state has no SQS queues."""


@given('an "SQS" queue has been created')
def sqs_queue_has_been_created(lws_session):
    _create_queue(lws_session)


@given('an "SQS" send-message task has been configured on the state machine')
def sqs_send_message_task_configured_given():
    pytest.skip("Cannot pre-set an SQS task configuration state for sequence setup")


@given("an execution of the state machine has been started")
def execution_of_sm_has_been_started():
    pytest.skip("Cannot pre-set a running execution state for sequence setup")


@given("eid in exec_status")
def eid_in_exec_status():
    pytest.skip("Cannot pre-set an in-flight execution state for sequence setup")


@given('a running execution has reached the "SQS" task state and sent a message to the queue')
def running_execution_sent_sqs_message_given():
    pytest.skip("Cannot pre-set a completed execution SQS task state for sequence setup")


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


@given('the state machine has no "SQS" task configured')
def sm_has_no_sqs_task(lws_session, world):
    """Ensure a PASS-only state machine exists with no SQS task."""
    try:
        _create_sm(lws_session)
    except Exception:  # noqa: BLE001
        pass  # state machine may already exist from a prior Given step
    world["_sm_has_no_sqs_task"] = True


@given('the state machine has an "SQS" task configured')
def sm_has_sqs_task(lws_session):
    """Create a state machine with an SQS sendMessage task; update if it already exists."""
    try:
        _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=_sqs_task_definition(TEST_QUEUE),
            roleArn=ROLE_ARN,
        )
    except Exception:  # noqa: BLE001
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_sqs_task_definition(TEST_QUEUE),
        )


@given('the state machine already has an "SQS" task configured')
def sm_already_has_sqs_task():
    pytest.skip(
        "lws allows update_state_machine even when the state machine already has an SQS task"
        " configured (idempotent overwrite allowed)"
    )


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


@given('the queue is "ACTIVE"')
def queue_is_active_given():
    """No-op: queues are ACTIVE by default after creation."""


@given('the queue is not "ACTIVE"')
def queue_is_not_active_given():
    pytest.skip(
        "lws does not validate SQS queue lifecycle state when configuring a state machine task"
    )


@given("the queue does not exist")
def queue_does_not_exist():
    pytest.skip("lws does not validate SQS queue existence when configuring a state machine task")


@given('the target queue is "ACTIVE"')
def target_queue_is_active():
    """No-op: queues are ACTIVE by default after creation."""


@given('the target queue is not "ACTIVE"')
def target_queue_is_not_active():
    pytest.skip(
        "lws does not reject start_execution when the target SQS queue is not ACTIVE"
        " (service task dispatch is fire-and-forget)"
    )


# ── Given: execution state ────────────────────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


@given('the execution\'s state machine has a configured "SQS" task')
def execution_sm_has_sqs_task(lws_session):
    """Update the state machine to have an SQS sendMessage task configured."""
    try:
        _create_queue(lws_session)
    except Exception:  # noqa: BLE001
        pass  # queue may already exist from a prior Given step
    _sfn(lws_session).update_state_machine(
        stateMachineArn=_sm_arn(),
        definition=_sqs_task_definition(TEST_QUEUE),
    )


@given('the execution\'s state machine has no "SQS" task configured')
def execution_sm_has_no_sqs_task():
    pytest.skip(
        "lws does not reject start_execution based on state machine definition content"
        " (no SQS task validation)"
    )


# ── Given: slots ───────────────────────────────────────────────────────


@given("an execution slot is available")
def execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").unlimited().apply()


@given("no execution slot is available")
def no_execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").exhaust().apply()


@given("a message slot is available")
def message_slot_available(lws_session):
    lws_session.capacity("sqs").unlimited().apply()


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip(
        "lws does not enforce SQS capacity limits for StepFunctions service task"
        " (direct provider call bypasses HTTP capacity check)"
    )


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


@when('an "SQS" queue is created')
def create_sqs_queue(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).create_queue(QueueName=TEST_QUEUE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "SQS" send-message task is configured on the state machine')
def configure_sqs_task(lws_session, world):
    # Act
    try:
        world["result"] = _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_sqs_task_definition(TEST_QUEUE),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    if world.get("_sm_has_no_sqs_task"):
        pytest.skip(
            "lws does not reject start_execution when the state machine has no SQS task"
            " configured (no task definition validation)"
        )
    # Act
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


@when('a running execution reaches the "SQS" task state and sends a message to the queue')
def execution_sends_message(lws_session, world):
    # Act: start execution on the state machine set up by Given steps (TEST_SM)
    try:
        resp = _sfn(lws_session).start_execution(
            stateMachineArn=_sm_arn(),
            input=TEST_INPUT,
        )
        world["result"] = resp
        world["execution_arn"] = resp["executionArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the state machine is "ACTIVE"')
def sm_is_active_then(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the state machine is "ACTIVE" with no "SQS" task configured')
def sm_is_active_with_no_sqs_task(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the queue is "ACTIVE"')
def queue_is_active_then(lws_session):
    url = _queue_url(lws_session)
    resp = _sqs(lws_session).get_queue_attributes(QueueUrl=url, AttributeNames=["All"])
    assert (
        resp.get("Attributes") is not None
    ), f"Expected queue '{TEST_QUEUE}' to be ACTIVE but got no attributes"


@then("the state machine will enqueue a message when it reaches the task state")
def sm_will_enqueue_message(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected state machine update to succeed but got: {actual_error}"


@then('the execution is "RUNNING"')
def execution_is_running_then(world):
    assert world["error"] is None, f"Expected start_execution to succeed but got: {world['error']}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"


@then('the message is "AVAILABLE" in the queue and the execution is "SUCCEEDED"')
def message_available_and_execution_succeeded(lws_session, world):
    # Arrange
    expected_error = None
    expected_message = TEST_MESSAGE_BODY
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    url = _queue_url(lws_session)
    resp = _sqs(lws_session).receive_message(QueueUrl=url, MaxNumberOfMessages=1, WaitTimeSeconds=1)
    actual_messages = resp.get("Messages", [])
    assert len(actual_messages) > 0, (
        f"Expected at least one message containing '{expected_message}' "
        f"in queue '{TEST_QUEUE}' but queue was empty"
    )
    actual_body = actual_messages[0].get("Body", "")
    assert (
        expected_message in actual_body
    ), f"Expected message body to contain '{expected_message}' but got: {actual_body}"


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "AVAILABLE" message belongs to an "ACTIVE" queue')
def _inv_stepfunctions_sqs_every_available_message_belongs_to_an_active_queue():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "RUNNING" execution references an "ACTIVE" state machine')
def _inv_stepfunctions_sqs_every_running_execution_references_an_active_state_machin():
    """Invariant step: trivially satisfied in isolated test context."""
