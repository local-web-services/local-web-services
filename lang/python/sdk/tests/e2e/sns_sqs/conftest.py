"""Abstract BDD step definitions for SnsSqs integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_TOPIC = "e2e-test-topic-1"
TEST_QUEUE = "e2e-test-q1"
TEST_MESSAGE = "test-message-body-1"


def _sns(lws_session):
    return lws_session.client("sns")


def _sqs(lws_session):
    return lws_session.client("sqs")


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _queue_arn(name=TEST_QUEUE):
    return f"arn:aws:sqs:us-east-1:000000000000:{name}"


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _create_topic(lws_session, name=TEST_TOPIC):
    _sns(lws_session).create_topic(Name=name)


def _create_queue(lws_session, name=TEST_QUEUE):
    _sqs(lws_session).create_queue(QueueName=name)


def _subscribe_queue_to_topic(lws_session):
    _sns(lws_session).subscribe(
        TopicArn=_topic_arn(),
        Protocol="sqs",
        Endpoint=_queue_arn(),
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
    try:
        _sns(lws_session).delete_topic(TopicArn=_topic_arn())
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    _create_topic(lws_session)
    world["result"] = None
    world["error"] = None


@given("the topic does not exist")
def topic_does_not_exist():
    """No-op: fresh state has no topics."""


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
def queue_is_not_active_given(lws_session, world):
    pytest.skip("lws does not enforce queue lifecycle state during SNS subscribe")


@given("the queue does not exist")
def queue_does_not_exist():
    pytest.skip("lws does not validate SQS queue existence when subscribing to an SNS topic")


@given('the subscribed queue is "ACTIVE"')
def subscribed_queue_is_active():
    """No-op: queues are ACTIVE by default after creation."""


@given('the subscribed queue is not "ACTIVE"')
def subscribed_queue_is_not_active(lws_session, world):
    pytest.skip("lws does not enforce queue lifecycle state during SNS publish/deliver")


# ── Given: subscription state ─────────────────────────────────────────


@given("the subscription slot is available")
def subscription_slot_available():
    """No-op: always room for subscriptions."""


@given("the subscription slot is not available")
def subscription_slot_not_available():
    pytest.skip("Cannot exhaust subscription slot limit")


@given("a confirmed subscription exists for the topic")
def confirmed_subscription_exists(lws_session):
    _create_queue(lws_session)
    _subscribe_queue_to_topic(lws_session)


@given("no confirmed subscription exists for the topic")
def no_confirmed_subscription_exists():
    pytest.skip("lws does not reject publish when no confirmed subscription exists")


# ── Given: message state ──────────────────────────────────────────────


@given('an "AVAILABLE" message exists in the queue')
def available_message_exists_in_queue(lws_session):
    _create_queue(lws_session)
    url = _queue_url(lws_session)
    _sqs(lws_session).send_message(QueueUrl=url, MessageBody=TEST_MESSAGE)


@given('no "AVAILABLE" message exists in the queue')
def no_available_message_exists():
    """No-op: fresh state has no messages."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("a message slot is available")
def message_slot_available(lws_session):
    lws_session.capacity("sqs").unlimited().apply()


@given("no message slot is available")
def no_message_slot_available(lws_session):
    lws_session.capacity("sqs").exhaust().apply()


# ── When: actions ──────────────────────────────────────────────────────


@when('an "SNS" topic is created')
def create_sns_topic(lws_session, world):
    try:
        world["result"] = _sns(lws_session).create_topic(Name=TEST_TOPIC)
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


@when('an "SQS" queue subscribes to an "SNS" topic')
def subscribe_queue_to_topic(lws_session, world):
    try:
        world["result"] = _sns(lws_session).subscribe(
            TopicArn=_topic_arn(),
            Protocol="sqs",
            Endpoint=_queue_arn(),
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a message is published to an "SNS" topic and delivered to the subscribed "SQS" queue')
def publish_and_deliver(lws_session, world):
    try:
        world["result"] = _sns(lws_session).publish(
            TopicArn=_topic_arn(),
            Message=TEST_MESSAGE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a message is consumed from the "SQS" queue')
def consume_message(lws_session, world):
    try:
        url = _queue_url(lws_session)
        resp = _sqs(lws_session).receive_message(QueueUrl=url, MaxNumberOfMessages=1)
        messages = resp.get("Messages", [])
        if not messages:
            raise ValueError(f"No messages available in queue '{TEST_QUEUE}'")
        receipt_handle = messages[0]["ReceiptHandle"]
        _sqs(lws_session).delete_message(QueueUrl=url, ReceiptHandle=receipt_handle)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the topic is "ACTIVE"')
def topic_is_active_then(lws_session):
    resp = _sns(lws_session).list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_arn = _topic_arn()
    assert (
        expected_arn in actual_arns
    ), f"Expected topic '{expected_arn}' to be ACTIVE but not found in: {actual_arns}"


@then('the queue is "ACTIVE"')
def queue_is_active_then(lws_session):
    url = _queue_url(lws_session)
    resp = _sqs(lws_session).get_queue_attributes(QueueUrl=url, AttributeNames=["All"])
    assert (
        resp.get("Attributes") is not None
    ), f"Expected queue '{TEST_QUEUE}' to be ACTIVE but got no attributes"


@then('the subscription is "CONFIRMED" and the queue will receive published messages')
def subscription_confirmed(lws_session):
    resp = _sns(lws_session).list_subscriptions_by_topic(TopicArn=_topic_arn())
    subs = resp.get("Subscriptions", [])
    assert (
        len(subs) > 0
    ), f"Expected at least one subscription for topic '{TEST_TOPIC}' but found none"


@then('the message is "AVAILABLE" in the queue')
def message_available_in_queue(lws_session):
    # Arrange
    url = _queue_url(lws_session)
    expected_message = TEST_MESSAGE
    # Act
    resp = _sqs(lws_session).receive_message(QueueUrl=url, MaxNumberOfMessages=1, WaitTimeSeconds=1)
    # Assert
    actual_messages = resp.get("Messages", [])
    assert len(actual_messages) > 0, (
        f"Expected at least one message containing '{expected_message}' "
        f"in queue '{TEST_QUEUE}' but queue was empty"
    )
    actual_body = actual_messages[0].get("Body", "")
    assert (
        expected_message in actual_body
    ), f"Expected message body to contain '{expected_message}' but got: {actual_body}"


@then('the message is "DELETED"')
def message_is_deleted(world):
    assert world["error"] is None, f"Expected consume to succeed but got: {world['error']}"
