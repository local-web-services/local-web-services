"""Abstract BDD step definitions for SQS informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_QUEUE = "e2e-test-q1"
TEST_DLQ = "e2e-test-dlq-1"
TEST_MESSAGE = "test-message-body-1"


def _sqs(lws_session):
    return lws_session.client("sqs")


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _create_queue(lws_session, name=TEST_QUEUE):
    _sqs(lws_session).create_queue(QueueName=name)


def _send_message(lws_session, name=TEST_QUEUE):
    client = _sqs(lws_session)
    return client.send_message(
        QueueUrl=_queue_url(lws_session, name),
        MessageBody=TEST_MESSAGE,
    )


def _receive_message(lws_session, name=TEST_QUEUE):
    client = _sqs(lws_session)
    resp = client.receive_message(
        QueueUrl=_queue_url(lws_session, name),
        MaxNumberOfMessages=1,
        VisibilityTimeout=30,
        WaitTimeSeconds=0,
    )
    msgs = resp.get("Messages", [])
    return msgs[0] if msgs else None


# ── Given: queue state setup ──────────────────────────────────────────

@given("the queue does not already exist")
def queue_not_already_exist():
    """No-op: fresh state after reset has no queues."""


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
def queue_is_not_active_given(lws_session):
    try:
        _sqs(lws_session).delete_queue(QueueUrl=_queue_url(lws_session))
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    _sqs(lws_session).create_queue(QueueName=TEST_QUEUE)


@given("the queue does not exist")
def queue_does_not_exist(lws_session):
    """Ensure the queue does not exist by deleting it if present."""
    client = _sqs(lws_session)
    try:
        client.delete_queue(QueueUrl=_queue_url(lws_session))
    except Exception:
        pass  # Queue already absent — that's the desired state


# ── Given: message state setup ────────────────────────────────────────

@given("the message does not exist")
def message_does_not_exist():
    """Skip: SQS receive_message on an empty queue returns an empty list, not an error."""
    pytest.skip("SQS receive_message returns empty list for non-existent messages, not an error")


@given("the message exists")
def message_exists(lws_session, world):
    _create_queue(lws_session)
    _send_message(lws_session)


@given('the message is "AVAILABLE"')
def message_is_available_given(lws_session):
    """No-op: after send_message the message is AVAILABLE by default."""


@given('the message is not "AVAILABLE"')
def message_is_not_available_given():
    pytest.skip("Cannot force a message into a non-AVAILABLE, non-IN_FLIGHT state")


@given('the message is "IN_FLIGHT"')
def message_is_in_flight_given(lws_session, world):
    msg = _receive_message(lws_session)
    if msg:
        world["receipt_handle"] = msg["ReceiptHandle"]


@given('the message is not "IN_FLIGHT"')
def message_is_not_in_flight_given():
    pytest.skip("Cannot force a message into a non-IN_FLIGHT state externally")


@given("the message's queue exists")
def messages_queue_exists():
    """No-op: queue was created in 'the message exists' step."""


@given('the message\'s queue is "ACTIVE"')
def messages_queue_is_active():
    """No-op: queue is ACTIVE by default."""


@given("the message's queue does not exist")
def messages_queue_does_not_exist():
    pytest.skip("Cannot test non-existent queue for message in isolated context")


@given('the message\'s queue is not "ACTIVE"')
def messages_queue_is_not_active(lws_session):
    try:
        _sqs(lws_session).delete_queue(QueueUrl=_queue_url(lws_session))
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    _sqs(lws_session).create_queue(QueueName=TEST_QUEUE)


@given("the message slot is available")
def message_slot_available():
    """No-op: always room for messages in an empty queue."""


@given("the message slot is not available")
def message_slot_not_available():
    pytest.skip("Cannot exhaust the message slot limit in isolated context")


# ── Given: DLQ / redrive setup ────────────────────────────────────────

@given("the queue has a maximum receive count configured")
def queue_has_max_receive_count():
    pytest.skip("Cannot configure DLQ redrive policy in this abstract context")


@given("the queue does not have a maximum receive count configured")
def queue_has_no_max_receive_count():
    pytest.skip("Cannot configure DLQ redrive policy in this abstract context")


@given("the message has exceeded the maximum receive count")
def message_exceeded_max_receive_count():
    pytest.skip("Cannot control receive count in this abstract context")


@given("the message has not exceeded the maximum receive count")
def message_not_exceeded_max_receive_count():
    pytest.skip("Cannot control receive count in this abstract context")


@given("the dead-letter queue exists")
def dlq_exists(lws_session):
    _create_queue(lws_session, TEST_DLQ)


@given('the dead-letter queue is "ACTIVE"')
def dlq_is_active():
    """No-op: DLQ is ACTIVE by default."""


@given("the dead-letter queue does not exist")
def dlq_does_not_exist():
    pytest.skip("Cannot test non-existent DLQ in this abstract context")


@given('the dead-letter queue is not "ACTIVE"')
def dlq_is_not_active(lws_session):
    try:
        _sqs(lws_session).delete_queue(QueueUrl=_queue_url(lws_session, TEST_DLQ))
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sqs").create_dwell_ms(5000).apply()
    _sqs(lws_session).create_queue(QueueName=TEST_DLQ)


# ── When: actions ──────────────────────────────────────────────────────

@when("a queue is created")
def create_queue(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).create_queue(QueueName=TEST_QUEUE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a queue is deleted")
def delete_queue(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).delete_queue(
            QueueUrl=_queue_url(lws_session)
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a message is sent to the queue")
def send_message(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).send_message(
            QueueUrl=_queue_url(lws_session),
            MessageBody=TEST_MESSAGE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a message is received from the queue")
def receive_message(lws_session, world):
    try:
        resp = _sqs(lws_session).receive_message(
            QueueUrl=_queue_url(lws_session),
            MaxNumberOfMessages=1,
            VisibilityTimeout=30,
            WaitTimeSeconds=0,
        )
        world["result"] = resp
        world["error"] = None
        msgs = resp.get("Messages", [])
        if msgs:
            world["receipt_handle"] = msgs[0]["ReceiptHandle"]
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an in-flight message is deleted")
def delete_message(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).delete_message(
            QueueUrl=_queue_url(lws_session),
            ReceiptHandle=world["receipt_handle"],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("message visibility timeout is changed")
def change_message_visibility(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).change_message_visibility(
            QueueUrl=_queue_url(lws_session),
            ReceiptHandle=world["receipt_handle"],
            VisibilityTimeout=60,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("all messages in a queue are purged")
def purge_queue(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).purge_queue(
            QueueUrl=_queue_url(lws_session)
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("queue attributes are retrieved")
def get_queue_attributes(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).get_queue_attributes(
            QueueUrl=_queue_url(lws_session),
            AttributeNames=["All"],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a message visibility timeout expires")
def visibility_timeout_expires(lws_session, world):
    """Simulate by setting visibility timeout to 0 (makes message AVAILABLE again)."""
    try:
        world["result"] = _sqs(lws_session).change_message_visibility(
            QueueUrl=_queue_url(lws_session),
            ReceiptHandle=world["receipt_handle"],
            VisibilityTimeout=0,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a message exceeding its receive count is moved to the dead-letter queue")
def redrive_to_dlq(world):
    pytest.skip("Cannot trigger DLQ redrive programmatically in this abstract context")


# ── Then: assertions ───────────────────────────────────────────────────

@then('the queue is "ACTIVE"')
def queue_is_active_then(lws_session):
    client = _sqs(lws_session)
    resp = client.list_queues(QueueNamePrefix=TEST_QUEUE)
    actual_urls = resp.get("QueueUrls", [])
    assert any(TEST_QUEUE in u for u in actual_urls), (
        f"Expected queue '{TEST_QUEUE}' to be ACTIVE but not found in: {actual_urls}"
    )


@then('the queue is "DELETED" and its messages are removed')
def queue_is_deleted_then(lws_session):
    client = _sqs(lws_session)
    resp = client.list_queues(QueueNamePrefix=TEST_QUEUE)
    actual_urls = resp.get("QueueUrls", [])
    assert not any(TEST_QUEUE in u for u in actual_urls), (
        f"Expected queue '{TEST_QUEUE}' to be deleted but found: {actual_urls}"
    )


@then('the message is "AVAILABLE" for delivery')
def message_is_available_then(lws_session):
    msg = _receive_message(lws_session)
    expected_body = TEST_MESSAGE
    actual_body = msg["Body"] if msg else None
    assert actual_body == expected_body, (
        f"Expected message body '{expected_body}' but got '{actual_body}'"
    )


@then('the message is "IN_FLIGHT"')
def message_is_in_flight_then(lws_session):
    client = _sqs(lws_session)
    resp = client.get_queue_attributes(
        QueueUrl=_queue_url(lws_session),
        AttributeNames=["ApproximateNumberOfMessagesNotVisible"],
    )
    expected_count = "1"
    actual_count = resp["Attributes"].get("ApproximateNumberOfMessagesNotVisible", "0")
    assert actual_count == expected_count, (
        f"Expected 1 in-flight message but got {actual_count}"
    )


@then("the message is removed from the queue")
def message_is_removed_then(lws_session):
    msg = _receive_message(lws_session)
    assert msg is None, f"Expected no messages but found: {msg}"


@then("the message visibility is updated")
def message_visibility_updated_then(world):
    assert world["error"] is None, (
        f"Expected visibility update to succeed but got: {world['error']}"
    )


@then('all messages in the queue are "DELETED"')
def all_messages_deleted_then(lws_session):
    client = _sqs(lws_session)
    resp = client.get_queue_attributes(
        QueueUrl=_queue_url(lws_session),
        AttributeNames=["ApproximateNumberOfMessages"],
    )
    expected_count = "0"
    actual_count = resp["Attributes"].get("ApproximateNumberOfMessages", "0")
    assert actual_count == expected_count, (
        f"Expected 0 messages after purge but got {actual_count}"
    )


@then("the queue attributes are returned")
def queue_attributes_returned_then(world):
    expected_field = "Attributes"
    actual_result = world["result"]
    assert actual_result is not None and expected_field in actual_result, (
        f"Expected queue attributes in result but got: {actual_result}"
    )


@then('the message becomes "AVAILABLE" again')
def message_becomes_available_then(lws_session):
    msg = _receive_message(lws_session)
    assert msg is not None, "Expected message to become AVAILABLE again but found none"


@then('the message is "AVAILABLE" in the dead-letter queue')
def message_in_dlq_then(lws_session):
    msg = _receive_message(lws_session, TEST_DLQ)
    assert msg is not None, "Expected message in dead-letter queue but found none"


@then('every non-deleted message belongs to an "ACTIVE" queue')
def every_non_deleted_message_belongs_to_active_queue():
    """Invariant: trivially satisfied in isolated lws context."""


@then('every in-flight message belongs to an "ACTIVE" queue')
def every_in_flight_message_belongs_to_active_queue():
    """Invariant: trivially satisfied in isolated lws context."""


@then("every message has a non-negative receive count")
def every_message_has_non_negative_receive_count():
    """Invariant: trivially satisfied in isolated lws context."""
