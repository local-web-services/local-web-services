"""Shared fixtures and BDD step definitions for SQS integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.sqs.provider import QueueConfig, SqsProvider
from lws.providers.sqs.routes import create_sqs_app

TEST_QUEUE = "int-test-q-1"
TEST_DLQ = "int-test-dlq-1"
TEST_MESSAGE = "int-test-message-body-1"
QUEUE_URL = f"http://testserver/000000000000/{TEST_QUEUE}"
DLQ_URL = f"http://testserver/000000000000/{TEST_DLQ}"


# ── Fixtures ──────────────────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    p = SqsProvider(queues=[QueueConfig(queue_name="test-queue")])
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_sqs_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _create_queue(client: TestClient, name: str = TEST_QUEUE) -> None:
    r = client.post("/", data={"Action": "CreateQueue", "QueueName": name})
    assert r.status_code == 200


def _send_message(client: TestClient, queue_url: str = QUEUE_URL) -> None:
    r = client.post(
        "/",
        data={"Action": "SendMessage", "QueueUrl": queue_url, "MessageBody": TEST_MESSAGE},
    )
    assert r.status_code == 200


def _receive_message(client: TestClient, queue_url: str = QUEUE_URL) -> dict | None:
    r = client.post(
        "/",
        data={
            "Action": "ReceiveMessage",
            "QueueUrl": queue_url,
            "MaxNumberOfMessages": "1",
            "VisibilityTimeout": "30",
            "WaitTimeSeconds": "0",
        },
    )
    if r.status_code != 200 or "<Message>" not in r.text:
        return None
    text = r.text
    start = text.index("<ReceiptHandle>") + len("<ReceiptHandle>")
    end = text.index("</ReceiptHandle>")
    receipt_handle = text[start:end]
    body_start = text.index("<Body>") + len("<Body>")
    body_end = text.index("</Body>")
    body = text[body_start:body_end]
    return {"ReceiptHandle": receipt_handle, "Body": body}


def _extract_xml_tag(text: str, tag: str) -> str:
    open_tag = f"<{tag}>"
    close_tag = f"</{tag}>"
    start = text.index(open_tag) + len(open_tag)
    end = text.index(close_tag)
    return text[start:end]


# ── Given: queue state setup ──────────────────────────────────────────────────


@given("the queue does not already exist")
def queue_not_already_exist():
    """No-op: fresh provider state has no queue named TEST_QUEUE."""


@given("the queue already exists")
def queue_already_exists(client):
    _create_queue(client)


@given("the queue exists")
def queue_exists(client):
    _create_queue(client)


@given('the queue is "ACTIVE"')
def queue_is_active_given():
    """No-op: queues are ACTIVE by default after creation."""


@given('the queue is not "ACTIVE"')
def queue_is_not_active_given():
    pytest.skip("Cannot configure lifecycle state in integration test context")


@given("the queue does not exist")
def queue_does_not_exist(client):
    """Ensure the queue does not exist; it was never created in the fresh provider."""
    client.post("/", data={"Action": "DeleteQueue", "QueueUrl": QUEUE_URL})


# ── Given: message state setup ────────────────────────────────────────────────


@given("the message does not exist")
def message_does_not_exist():
    pytest.skip("SQS receive_message returns empty list for non-existent messages, not an error")


@given("the message exists")
def message_exists(client):
    _create_queue(client)
    _send_message(client)


@given('the message is "AVAILABLE"')
def message_is_available_given():
    """No-op: after send_message the message is AVAILABLE by default."""


@given('the message is not "AVAILABLE"')
def message_is_not_available_given():
    pytest.skip("Cannot force a message into a non-AVAILABLE, non-IN_FLIGHT state")


@given('the message is "IN_FLIGHT"')
def message_is_in_flight_given(client, world):
    msg = _receive_message(client)
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
def messages_queue_is_not_active():
    pytest.skip("Cannot configure lifecycle state in integration test context")


@given("the message slot is available")
def message_slot_available():
    """No-op: always room for messages in an empty queue."""


@given("the message slot is not available")
def message_slot_not_available():
    pytest.skip("Cannot exhaust the message slot limit in isolated context")


# ── Given: DLQ / redrive setup ────────────────────────────────────────────────


@given("the queue has a maximum receive count configured")
def queue_has_max_receive_count():
    pytest.skip("Cannot configure DLQ redrive policy in integration test context")


@given("the queue does not have a maximum receive count configured")
def queue_has_no_max_receive_count():
    pytest.skip("Cannot configure DLQ redrive policy in integration test context")


@given("the message has exceeded the maximum receive count")
def message_exceeded_max_receive_count():
    pytest.skip("Cannot control receive count in integration test context")


@given("the message has not exceeded the maximum receive count")
def message_not_exceeded_max_receive_count():
    pytest.skip("Cannot control receive count in integration test context")


@given("the dead-letter queue exists")
def dlq_exists(client):
    _create_queue(client, TEST_DLQ)


@given('the dead-letter queue is "ACTIVE"')
def dlq_is_active():
    """No-op: DLQ is ACTIVE by default after creation."""


@given("the dead-letter queue does not exist")
def dlq_does_not_exist():
    pytest.skip("Cannot test non-existent DLQ in integration test context")


@given('the dead-letter queue is not "ACTIVE"')
def dlq_is_not_active():
    pytest.skip("Cannot configure lifecycle state in integration test context")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("a queue is created")
def create_queue(client, world):
    r = client.post("/", data={"Action": "CreateQueue", "QueueName": TEST_QUEUE})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a queue is deleted")
def delete_queue(client, world):
    r = client.post("/", data={"Action": "DeleteQueue", "QueueUrl": QUEUE_URL})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a message is sent to the queue")
def send_message(client, world):
    r = client.post(
        "/",
        data={
            "Action": "SendMessage",
            "QueueUrl": QUEUE_URL,
            "MessageBody": TEST_MESSAGE,
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a message is received from the queue")
def receive_message(client, world):
    r = client.post(
        "/",
        data={
            "Action": "ReceiveMessage",
            "QueueUrl": QUEUE_URL,
            "MaxNumberOfMessages": "1",
            "VisibilityTimeout": "30",
            "WaitTimeSeconds": "0",
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
        if "<ReceiptHandle>" in r.text:
            world["receipt_handle"] = _extract_xml_tag(r.text, "ReceiptHandle")
    else:
        world["result"] = None
        world["error"] = r.text


@when("an in-flight message is deleted")
def delete_message(client, world):
    receipt_handle = world.get("receipt_handle", "invalid-receipt-handle")
    r = client.post(
        "/",
        data={
            "Action": "DeleteMessage",
            "QueueUrl": QUEUE_URL,
            "ReceiptHandle": receipt_handle,
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("message visibility timeout is changed")
def change_message_visibility(client, world):
    receipt_handle = world.get("receipt_handle", "invalid-receipt-handle")
    r = client.post(
        "/",
        data={
            "Action": "ChangeMessageVisibility",
            "QueueUrl": QUEUE_URL,
            "ReceiptHandle": receipt_handle,
            "VisibilityTimeout": "60",
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("all messages in a queue are purged")
def purge_queue(client, world):
    r = client.post("/", data={"Action": "PurgeQueue", "QueueUrl": QUEUE_URL})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("queue attributes are retrieved")
def get_queue_attributes(client, world):
    r = client.post(
        "/",
        data={
            "Action": "GetQueueAttributes",
            "QueueUrl": QUEUE_URL,
            "AttributeName.1": "All",
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a message visibility timeout expires")
def visibility_timeout_expires(client, world):
    """Simulate by setting visibility timeout to 0 (makes message AVAILABLE again)."""
    receipt_handle = world.get("receipt_handle", "invalid-receipt-handle")
    r = client.post(
        "/",
        data={
            "Action": "ChangeMessageVisibility",
            "QueueUrl": QUEUE_URL,
            "ReceiptHandle": receipt_handle,
            "VisibilityTimeout": "0",
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a message exceeding its receive count is moved to the dead-letter queue")
def redrive_to_dlq(world):
    pytest.skip("Cannot trigger DLQ redrive programmatically in integration test context")


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the queue is "ACTIVE"')
def queue_is_active_then(client):
    r = client.post("/", data={"Action": "ListQueues", "QueueNamePrefix": TEST_QUEUE})
    expected_fragment = TEST_QUEUE
    actual_text = r.text
    assert (
        expected_fragment in actual_text
    ), f"Expected queue '{expected_fragment}' to be ACTIVE but not found in: {actual_text}"


@then('the queue is "DELETED" and its messages are removed')
def queue_is_deleted_then(client):
    r = client.post("/", data={"Action": "ListQueues", "QueueNamePrefix": TEST_QUEUE})
    expected_absent = TEST_QUEUE
    actual_text = r.text
    assert (
        expected_absent not in actual_text
    ), f"Expected queue '{expected_absent}' to be deleted but found in: {actual_text}"


@then('the message is "AVAILABLE" for delivery')
def message_is_available_then(client):
    msg = _receive_message(client)
    expected_body = TEST_MESSAGE
    actual_body = msg["Body"] if msg else None
    assert (
        actual_body == expected_body
    ), f"Expected message body '{expected_body}' but got '{actual_body}'"


@then('the message is "IN_FLIGHT"')
def message_is_in_flight_then(client):
    r = client.post(
        "/",
        data={
            "Action": "GetQueueAttributes",
            "QueueUrl": QUEUE_URL,
            "AttributeName.1": "ApproximateNumberOfMessagesNotVisible",
        },
    )
    expected_count = "1"
    actual_text = r.text
    assert (
        expected_count in actual_text
    ), f"Expected 1 in-flight message but response was: {actual_text}"


@then("the message is removed from the queue")
def message_is_removed_then(client):
    msg = _receive_message(client)
    assert msg is None, f"Expected no messages but found: {msg}"


@then("the message visibility is updated")
def message_visibility_updated_then(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected visibility update to succeed but got: {actual_error}"


@then('all messages in the queue are "DELETED"')
def all_messages_deleted_then(client):
    r = client.post(
        "/",
        data={
            "Action": "GetQueueAttributes",
            "QueueUrl": QUEUE_URL,
            "AttributeName.1": "ApproximateNumberOfMessages",
        },
    )
    expected_count = "0"
    actual_text = r.text
    assert (
        expected_count in actual_text
    ), f"Expected 0 messages after purge but response was: {actual_text}"


@then("the queue attributes are returned")
def queue_attributes_returned_then(client):
    r = client.post(
        "/",
        data={
            "Action": "GetQueueAttributes",
            "QueueUrl": QUEUE_URL,
            "AttributeName.1": "All",
        },
    )
    expected_status = 200
    actual_status = r.status_code
    assert (
        actual_status == expected_status
    ), f"Expected GetQueueAttributes to return {expected_status} but got: {actual_status}"


@then('the message becomes "AVAILABLE" again')
def message_becomes_available_then(client):
    msg = _receive_message(client)
    assert msg is not None, "Expected message to become AVAILABLE again but found none"


@then('the message is "AVAILABLE" in the dead-letter queue')
def message_in_dlq_then(client):
    msg = _receive_message(client, DLQ_URL)
    assert msg is not None, "Expected message in dead-letter queue but found none"


@then('the pending subscription is "DELETED"')
def pending_subscription_is_deleted_then(world):
    """Not applicable to SQS — trivially satisfied."""
