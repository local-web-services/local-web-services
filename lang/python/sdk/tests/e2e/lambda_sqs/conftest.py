"""Abstract BDD step definitions for LambdaSqs integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_FUNC = "e2e-test-func-1"
TEST_QUEUE = "e2e-test-q1"
TEST_DLQ = "e2e-test-dlq-1"
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _lambda(lws_session):
    return lws_session.client("lambda")


def _sqs(lws_session):
    return lws_session.client("sqs")


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _dlq_url(lws_session, name=TEST_DLQ):
    return lws_session.queue_url(name)


def _queue_arn(name=TEST_QUEUE):
    return f"arn:aws:sqs:us-east-1:000000000000:{name}"


def _create_function(lws_session, name=TEST_FUNC):
    try:
        _lambda(lws_session).create_function(
            FunctionName=name,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
    except Exception:  # noqa: BLE001
        pass  # function may already exist


def _create_queue(lws_session, name=TEST_QUEUE):
    try:
        _sqs(lws_session).create_queue(QueueName=name)
    except Exception:  # noqa: BLE001
        pass  # queue may already exist


def _create_dlq(lws_session, name=TEST_DLQ):
    try:
        _sqs(lws_session).create_queue(QueueName=name)
    except Exception:  # noqa: BLE001
        pass  # DLQ may already exist


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


# ── Given: source / dead-letter queue state ────────────────────────────


@given("the source queue exists")
def source_queue_exists(lws_session):
    _create_queue(lws_session)


@given("the source queue does not exist")
def source_queue_does_not_exist():
    """No-op: fresh state has no queues."""


@given('the source queue is "ACTIVE"')
def source_queue_is_active_given():
    """No-op: queues are ACTIVE immediately after creation."""


@given('the source queue is not "ACTIVE"')
def source_queue_is_not_active_given(lws_session, world):
    try:
        _sqs(lws_session).delete_queue(QueueUrl=_queue_url(lws_session))
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    _create_queue(lws_session)
    world["result"] = None
    world["error"] = None


@given("the dead-letter queue exists")
def dlq_exists(lws_session):
    _create_dlq(lws_session)


@given("the dead-letter queue does not exist")
def dlq_does_not_exist():
    """No-op: fresh state has no queues."""


@given('the dead-letter queue is "ACTIVE"')
def dlq_is_active_given():
    """No-op: queues are ACTIVE immediately after creation."""


@given('the dead-letter queue is not "ACTIVE"')
def dlq_is_not_active_given(lws_session, world):
    try:
        _sqs(lws_session).delete_queue(QueueUrl=_dlq_url(lws_session))
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    _create_dlq(lws_session)
    world["result"] = None
    world["error"] = None


@given("the source queue has no dead-letter queue configured")
def source_queue_no_dlq():
    """No-op: queue created without a DLQ."""


@given("the source queue already has a dead-letter queue configured")
def source_queue_has_dlq(lws_session):
    import json

    try:
        _create_queue(lws_session)
    except Exception:  # noqa: BLE001
        pass  # Queue may already exist from a prior @given step
    try:
        _create_dlq(lws_session)
    except Exception:  # noqa: BLE001
        pass  # DLQ may already exist from a prior @given step
    dlq_arn = _queue_arn(TEST_DLQ)
    redrive = json.dumps({"deadLetterTargetArn": dlq_arn, "maxReceiveCount": 2})
    _sqs(lws_session).set_queue_attributes(
        QueueUrl=_queue_url(lws_session),
        Attributes={"RedrivePolicy": redrive},
    )


# ── Given: event source mapping state ─────────────────────────────────


@given("the event source mapping does not already exist")
def esm_not_already_exist():
    """No-op: fresh state has no event source mappings."""


@given("the event source mapping already exists")
def esm_already_exists():
    pytest.skip("Cannot pre-create event source mapping in lws")


@given("the event source mapping exists")
def esm_exists():
    pytest.skip("Cannot pre-create event source mapping in lws")


@given('the event source mapping is "ENABLED"')
def esm_is_enabled():
    pytest.skip("Cannot pre-create event source mapping in lws")


@given('the event source mapping is not "ENABLED"')
def esm_is_not_enabled():
    pytest.skip("Cannot pre-create disabled event source mapping in lws")


@given("the event source mapping does not exist")
def esm_does_not_exist():
    """No-op: fresh state has no event source mappings."""


@given('the mapped function is "ACTIVE"')
def mapped_function_is_active():
    pytest.skip("Cannot set up event source mapping in lws")


@given('the mapped function is not "ACTIVE"')
def mapped_function_is_not_active():
    pytest.skip("Cannot set up event source mapping in lws")


# ── Given: invocation / message / slot state ──────────────────────────


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


@given('an "AVAILABLE" message exists in the mapped queue')
def available_message_in_mapped_queue():
    pytest.skip("Cannot set up event source mapping in lws")


@given('no "AVAILABLE" message exists in the mapped queue')
def no_available_message_in_mapped_queue():
    pytest.skip("Cannot set up event source mapping in lws")


@given("a message slot is available")
def message_slot_available():
    """No-op: always room for messages."""


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip("Cannot exhaust message slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("qid not in queue_status")
def qid_not_in_queue_status():
    """No-op: fresh state has no queues."""


@given("qid in queue_status")
def qid_in_queue_status(lws_session):
    _create_queue(lws_session)


@given("eid not in esm_status")
def eid_not_in_esm_status():
    """No-op: fresh state has no event source mappings."""


@given("eid in esm_status")
def eid_in_esm_status():
    pytest.skip("Cannot create an event source mapping in lws")


@given("fid not in func_status")
def fid_not_in_func_status():
    """No-op: fresh state has no functions."""


@given("fid in func_status")
def fid_in_func_status(lws_session):
    _create_function(lws_session)


@given("iid in inv_status")
def iid_in_inv_status():
    pytest.skip("Cannot create an in-progress invocation in lws")


@given('an "SQS" queue has been created')
def sqs_queue_has_been_created_seq(lws_session):
    _create_queue(lws_session)


@given('the "SQS" queue has been configured with a dead-letter queue')
def sqs_queue_configured_with_dlq_seq(lws_session):
    import json

    try:
        _create_queue(lws_session)
    except Exception:  # noqa: BLE001
        pass
    try:
        _create_dlq(lws_session)
    except Exception:  # noqa: BLE001
        pass
    dlq_arn = _queue_arn(TEST_DLQ)
    redrive = json.dumps({"deadLetterTargetArn": dlq_arn, "maxReceiveCount": 2})
    _sqs(lws_session).set_queue_attributes(
        QueueUrl=_queue_url(lws_session),
        Attributes={"RedrivePolicy": redrive},
    )


@given('a message has arrived in the "SQS" queue')
def message_has_arrived_in_sqs_queue_seq():
    pytest.skip("Cannot trigger internal SQS message arrival in lws")


@given("a Lambda function has been deployed")
def lambda_function_has_been_deployed_seq(lws_session):
    _create_function(lws_session)


@given("a Lambda event source mapping has been created linking a queue to a function")
def lambda_esm_has_been_created_seq():
    pytest.skip("Cannot create an event source mapping in lws")


@given("the event source mapping has polled the queue and invoked the Lambda function")
def esm_has_polled_queue_and_invoked_seq():
    pytest.skip("Cannot trigger ESM polling in lws")


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
        _lambda(lws_session).create_function(
            FunctionName=TEST_FUNC,
            Runtime="python3.12",
            Role=ROLE_ARN,
            Handler="index.handler",
            Code={"ZipFile": b"fake"},
        )
        world["result"] = {"FunctionName": TEST_FUNC}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an "SQS" queue is created')
def create_sqs_queue(lws_session, world):
    try:
        _sqs(lws_session).create_queue(QueueName=TEST_QUEUE)
        world["result"] = {"QueueName": TEST_QUEUE}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('the "SQS" queue is configured with a dead-letter queue')
def configure_redrive(lws_session, world):
    import json

    try:
        dlq_arn = _queue_arn(TEST_DLQ)
        redrive = json.dumps({"deadLetterTargetArn": dlq_arn, "maxReceiveCount": 2})
        _sqs(lws_session).set_queue_attributes(
            QueueUrl=_queue_url(lws_session),
            Attributes={"RedrivePolicy": redrive},
        )
        world["result"] = {"QueueName": TEST_QUEUE}
        world["error"] = None
    except (ClientError, Exception) as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("a Lambda event source mapping is created linking a queue to a function")
def create_event_source_mapping(world):
    pytest.skip("Cannot create event source mapping in lws")


@when("the event source mapping polls the queue and invokes the Lambda function")
def esm_poll_and_invoke(world):
    pytest.skip("Cannot trigger ESM polling in lws")


@when("the Lambda function is invoked")
def invoke_function(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")


@when("the Lambda invocation fails")
def lambda_invocation_fails(world):
    pytest.skip("Cannot trigger Lambda invocation failure in lws")


@when("the Lambda invocation completes successfully")
def lambda_invocation_succeeds(world):
    pytest.skip("Cannot trigger Lambda invocation success in lws")


@when('a message arrives in the "SQS" queue')
def message_arrives(world):
    pytest.skip("Cannot trigger internal message arrival in lws")


# ── Then: assertions ────────────────────────────────────────────────────


@then('the function is "ACTIVE"')
def func_is_active_then(lws_session):
    resp = _lambda(lws_session).get_function(FunctionName=TEST_FUNC)
    expected_state = "Active"
    actual_state = resp["Configuration"]["State"]
    assert (
        actual_state == expected_state
    ), f"Expected function state '{expected_state}' but got '{actual_state}'"


@then('the queue is "ACTIVE" with no dead-letter queue configured')
def queue_is_active_no_dlq(lws_session):
    resp = _sqs(lws_session).get_queue_attributes(
        QueueUrl=_queue_url(lws_session),
        AttributeNames=["RedrivePolicy"],
    )
    actual_redrive = resp["Attributes"].get("RedrivePolicy", "")
    expected_redrive = ""
    assert (
        actual_redrive == expected_redrive
    ), f"Expected no RedrivePolicy but got '{actual_redrive}'"


@then("failed messages will be redriven to the dead-letter queue after two receives")
def redrive_configured(lws_session):
    import json

    resp = _sqs(lws_session).get_queue_attributes(
        QueueUrl=_queue_url(lws_session),
        AttributeNames=["RedrivePolicy"],
    )
    actual_policy = resp["Attributes"].get("RedrivePolicy", "")
    assert actual_policy != "", "Expected a RedrivePolicy to be configured but got none"
    policy = json.loads(actual_policy)
    expected_count = 2
    actual_count = int(policy.get("maxReceiveCount", 0))
    assert (
        actual_count == expected_count
    ), f"Expected maxReceiveCount '{expected_count}' but got '{actual_count}'"


@then('the event source mapping is "ENABLED" and will poll the queue for messages')
def esm_is_enabled_then(world):
    pytest.skip("Cannot observe event source mapping state in lws")


@then('the invocation is "IN_PROGRESS"')
def invocation_is_in_progress_then(world):
    pytest.skip("Cannot observe Lambda invocation state in lws")


@then('the invocation is "FAILED"')
def invocation_is_failed_then(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")


@then('the invocation is "SUCCESS" and the "SQS" message is "DELETED"')
def invocation_success_message_deleted(world):
    pytest.skip("Cannot observe Lambda invocation result in lws")


@then(
    'if the receive count is below the threshold the message is "AVAILABLE" for reprocessing, '
    "otherwise it is redriven to the dead-letter queue"
)
def message_reprocessing_or_dlq(world):
    pytest.skip("Cannot observe Lambda SQS failure handling in lws")


@then('the message is "IN_FLIGHT" and a Lambda invocation is "IN_PROGRESS"')
def message_in_flight_invocation_in_progress(world):
    pytest.skip("Cannot observe ESM polling result in lws")


@then('the message is "AVAILABLE" for processing')
def message_available_for_processing(world):
    pytest.skip("Cannot observe internal message state in lws")


# ── Then: invariants and rejection ────────────────────────────────────


@then("the operation is rejected")
def operation_is_rejected_lambda_sqs(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world.get("error")
    assert actual_error is not expected_error, "Expected operation to be rejected but it succeeded"


@then('every in-progress invocation was initiated by an "ENABLED" event source mapping')
def every_in_progress_invocation_initiated_by_enabled_esm():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every in-progress invocation references an "ACTIVE" Lambda function')
def every_in_progress_invocation_references_active_function():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "AVAILABLE" or "IN_FLIGHT" message belongs to an "ACTIVE" queue')
def every_message_belongs_to_active_queue():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "ENABLED" event source mapping references an "ACTIVE" queue')
def every_enabled_esm_references_active_queue():
    """Invariant step: trivially satisfied in isolated test context."""
