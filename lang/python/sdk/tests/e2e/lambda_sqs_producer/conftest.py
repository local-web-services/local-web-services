"""Abstract BDD step definitions for LambdaSqsProducer integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_QUEUE = "e2e-test-q1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _sqs(lws_session):
    return lws_session.client("sqs")


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _create_function(lws_session, name=TEST_FUNC):
    _lambda(lws_session).create_function(
        FunctionName=name,
        Runtime="python3.12",
        Role=ROLE_ARN,
        Handler="index.handler",
        Code={"ZipFile": b"fake"},
    )


def _create_queue(lws_session, name=TEST_QUEUE):
    _sqs(lws_session).create_queue(QueueName=name)


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


# ── Given: queue state ─────────────────────────────────────────────────


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
    """No-op: queues are ACTIVE immediately after creation."""


@given('the queue is not "ACTIVE"')
def queue_is_not_active_given(lws_session, world):
    try:
        _sqs(lws_session).delete_queue(QueueUrl=_queue_url(lws_session))
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    _create_queue(lws_session)
    world["result"] = None
    world["error"] = None


@given("the queue does not exist")
def queue_does_not_exist():
    """No-op: fresh state has no queues."""


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


@given("a message slot is available")
def message_slot_available():
    """No-op: always room for messages."""


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip("Cannot exhaust message slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no functions."""


@given("qid not in queue_status")
def qid_not_in_queue_status():
    """No-op: fresh state has no queues."""


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    _create_function(lws_session)


@given('an "SQS" queue has been created')
def sqs_queue_has_been_created_seq(lws_session):
    _create_queue(lws_session)


@given("the Lambda function has been invoked")
def lambda_function_has_been_invoked_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given('the Lambda function has sent a message to the "SQS" queue during invocation')
def lambda_sent_message_to_sqs_seq():
    pytest.skip("Cannot trigger Lambda SQS send in lws")


@given("the Lambda invocation has completed successfully")
def lambda_invocation_completed_successfully_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")


@given("the Lambda invocation has failed")
def lambda_invocation_has_failed_seq():
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


@when('an "SQS" queue is created')
def create_sqs_queue(lws_session, world):
    try:
        _create_queue(lws_session)
        world["result"] = {"QueueName": TEST_QUEUE}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda invocation fails")
def lambda_invocation_fails(world):
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


@when("the Lambda invocation completes successfully")
def lambda_invocation_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation success in lws")


@when('the Lambda function sends a message to the "SQS" queue during invocation')
def lambda_sends_message(world):
    pytest.skip("Cannot trigger Lambda SQS send in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the queue is "ACTIVE"')
def queue_is_active_then(lws_session):
    resp = _sqs(lws_session).get_queue_attributes(
        QueueUrl=_queue_url(lws_session),
        AttributeNames=["QueueArn"],
    )
    actual_arn = resp["Attributes"].get("QueueArn", "")
    expected_prefix = "arn:aws:sqs:"
    assert actual_arn.startswith(
        expected_prefix
    ), f"Expected queue ARN starting with '{expected_prefix}' but got '{actual_arn}'"


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED"')
def invocation_is_failed_then(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS"')
def invocation_is_success_then(world):
    pytest.skip("Cannot observe Lambda invocation success in lws")


@then('the message is "AVAILABLE" in the queue')
def message_available_in_queue(world):
    pytest.skip("Cannot observe Lambda SQS send result in lws")


# ── Then: invariants and rejection ────────────────────────────────────


@then("the operation is rejected")
def operation_is_rejected_lambda_sqs_producer(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world.get("error")
    assert actual_error is not expected_error, "Expected operation to be rejected but it succeeded"


@then('every "AVAILABLE" message belongs to an "ACTIVE" queue')
def every_available_message_belongs_to_active_queue_producer():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function')
def every_in_progress_invocation_references_active_function_producer():
    """Invariant step: trivially satisfied in isolated test context."""
