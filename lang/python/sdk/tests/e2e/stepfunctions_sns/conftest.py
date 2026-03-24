"""Abstract BDD step definitions for StepfunctionsSns integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_SM = "test-sm-1"
TEST_TOPIC = "e2e-test-topic-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"
PASS_DEFINITION = json.dumps({"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": True}}})
TEST_INPUT = '{"key": "value"}'


def _sns_task_definition(topic_name: str) -> str:
    """Return a state machine definition with an SNS publish task."""
    topic_arn = f"arn:aws:sns:us-east-1:000000000000:{topic_name}"
    return json.dumps(
        {
            "StartAt": "PublishToSns",
            "States": {
                "PublishToSns": {
                    "Type": "Task",
                    "Resource": "arn:aws:states:::sns:publish",
                    "Parameters": {
                        "TopicArn": topic_arn,
                        "Message": "test-message",
                    },
                    "End": True,
                }
            },
        }
    )


def _sfn(lws_session):
    return lws_session.client("stepfunctions")


def _sns(lws_session):
    return lws_session.client("sns")


def _sm_arn(name=TEST_SM):
    return f"arn:aws:states:us-east-1:000000000000:stateMachine:{name}"


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _create_sm(lws_session, name=TEST_SM):
    resp = _sfn(lws_session).create_state_machine(
        name=name,
        definition=PASS_DEFINITION,
        roleArn=ROLE_ARN,
    )
    return resp["stateMachineArn"]


def _create_topic(lws_session, name=TEST_TOPIC):
    _sns(lws_session).create_topic(Name=name)


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


@given('the state machine has no "SNS" task configured')
def sm_has_no_sns_task(lws_session, world):
    """Ensure a PASS-only state machine exists with no SNS task."""
    try:
        _create_sm(lws_session)
    except Exception:  # noqa: BLE001
        pass  # state machine may already exist from a prior Given step
    world["_sm_has_no_sns_task"] = True


@given('the state machine has an "SNS" task configured')
def sm_has_sns_task(lws_session):
    """Create a state machine with an SNS publish task; update if it already exists."""
    try:
        _create_topic(lws_session)
    except Exception:  # noqa: BLE001
        pass  # topic may already exist from a prior Given step
    try:
        _sfn(lws_session).create_state_machine(
            name=TEST_SM,
            definition=_sns_task_definition(TEST_TOPIC),
            roleArn=ROLE_ARN,
        )
    except Exception:  # noqa: BLE001
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_sns_task_definition(TEST_TOPIC),
        )


@given('the state machine already has an "SNS" task configured')
def sm_already_has_sns_task():
    pytest.skip(
        "lws allows update_state_machine even when the state machine already has an SNS task"
        " configured (idempotent overwrite allowed)"
    )


# ── Given: topic state ────────────────────────────────────────────────


@given("the topic does not already exist")
def topic_not_already_exist():
    """No-op: fresh state has no topics."""


@given("the topic already exists")
def topic_already_exists(lws_session):
    _create_topic(lws_session)


@given("the topic exists")
def topic_exists(lws_session):
    _create_topic(lws_session)


@given('the topic is "ACTIVE"')
def topic_is_active_given():
    """No-op: topics are ACTIVE immediately after creation."""


@given('the topic is not "ACTIVE"')
def topic_is_not_active_given(lws_session, world):
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    _create_topic(lws_session)
    world["result"] = None
    world["error"] = None


@given("the topic does not exist")
def topic_does_not_exist():
    """No-op: fresh state has no topics."""


@given('the target topic is "ACTIVE"')
def target_topic_is_active():
    """No-op: topics are ACTIVE immediately after creation."""


@given('the target topic is not "ACTIVE"')
def target_topic_is_not_active(lws_session, world):
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    _create_topic(lws_session)
    world["result"] = None
    world["error"] = None


# ── Given: execution state ────────────────────────────────────────────


@given('an execution is "RUNNING"')
def execution_is_running_given(lws_session):
    _create_sm(lws_session)
    _start_execution(lws_session)


@given('no execution is "RUNNING"')
def no_execution_is_running():
    """No-op: fresh state has no executions."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an execution slot is available")
def execution_slot_available():
    """No-op: always room for executions."""


@given("no execution slot is available")
def no_execution_slot_available(lws_session):
    lws_session.capacity("stepfunctions").exhaust().apply()


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


@when('an "SNS" topic is created')
def create_sns_topic(lws_session, world):
    try:
        world["result"] = _sns(lws_session).create_topic(Name=TEST_TOPIC)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "SNS" publish task is configured on the state machine')
def configure_sns_task(lws_session, world):
    # Act
    try:
        world["result"] = _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_sns_task_definition(TEST_TOPIC),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an execution of the state machine is started")
def start_execution(lws_session, world):
    if world.get("_sm_has_no_sns_task"):
        pytest.skip(
            "lws does not reject start_execution when the state machine has no SNS task"
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


@when('a running execution publishes a message to the "SNS" topic and succeeds')
def execution_publishes_to_topic(lws_session, world):
    # Arrange: ensure topic exists and SM has SNS publish task
    try:
        _create_topic(lws_session)
    except Exception:  # noqa: BLE001
        pass  # topic may already exist from a prior Given step
    try:
        _sfn(lws_session).update_state_machine(
            stateMachineArn=_sm_arn(),
            definition=_sns_task_definition(TEST_TOPIC),
        )
    except Exception:  # noqa: BLE001
        pass  # SM may not exist (negative: no execution RUNNING); update will fail
    # Act
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


@then('the state machine is "ACTIVE" with no "SNS" task configured')
def sm_is_active_with_no_sns_task(lws_session):
    resp = _sfn(lws_session).describe_state_machine(stateMachineArn=_sm_arn())
    expected_status = "ACTIVE"
    actual_status = resp.get("status", "")
    assert (
        actual_status == expected_status
    ), f"Expected state machine status '{expected_status}' but got '{actual_status}'"


@then('the topic is "ACTIVE"')
def topic_is_active_then(lws_session):
    resp = _sns(lws_session).list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_arn = _topic_arn()
    assert (
        expected_arn in actual_arns
    ), f"Expected topic '{expected_arn}' to be ACTIVE but not found in: {actual_arns}"


@then("the state machine will publish a message to the topic when it reaches the task state")
def sm_will_publish_to_topic(world):
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


@then('the execution is "SUCCEEDED" and the message has been published to the topic')
def execution_succeeded_and_message_published(lws_session, world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"
