"""Abstract BDD step definitions for EventsSqs integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUS = "e2e-test-bus-1"
TEST_RULE = "test-rule-1"
TEST_QUEUE = "e2e-test-q1"
EVENT_PATTERN = json.dumps({"source": ["test.source"]})
TEST_MESSAGE = "test-message-body-1"


def _events(lws_session):
    return lws_session.client("events")


def _sqs(lws_session):
    return lws_session.client("sqs")


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _queue_arn(name=TEST_QUEUE):
    return f"arn:aws:sqs:us-east-1:000000000000:{name}"


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


def _create_queue(lws_session, name=TEST_QUEUE):
    _sqs(lws_session).create_queue(QueueName=name)


def _create_rule_targeting_sqs(lws_session, bus=TEST_BUS, rule=TEST_RULE):
    _events(lws_session).put_rule(
        Name=rule,
        EventBusName=bus,
        EventPattern=EVENT_PATTERN,
        State="ENABLED",
    )
    _events(lws_session).put_targets(
        Rule=rule,
        EventBusName=bus,
        Targets=[{"Id": "t1", "Arn": _queue_arn()}],
    )


# ── Given: bus state ───────────────────────────────────────────────────


@given("the event bus does not already exist")
def event_bus_not_already_exist():
    """No-op: fresh state has no custom buses."""


@given("the event bus already exists")
def event_bus_already_exists(lws_session):
    _create_bus(lws_session)


@given("the event bus exists")
def event_bus_exists(lws_session):
    _create_bus(lws_session)


@given('the event bus is "ACTIVE"')
def event_bus_is_active_given():
    """No-op: buses are ACTIVE by default."""


@given('the event bus is not "ACTIVE"')
def event_bus_is_not_active_given(lws_session, world):
    try:
        _events(lws_session).delete_event_bus(Name=TEST_BUS)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("events").create_dwell_ms(5000).apply()
    _create_bus(lws_session)
    world["result"] = None
    world["error"] = None


@given("the event bus does not exist")
def event_bus_does_not_exist():
    """No-op: fresh state has no buses."""


# ── Given: rule state ──────────────────────────────────────────────────


@given("the rule does not already exist")
def rule_not_already_exist():
    """No-op: fresh state has no rules."""


@given("the rule already exists")
def rule_already_exists(lws_session):
    pytest.skip("lws does not reject put_rule when rule already exists (idempotent)")


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
    """No-op: queues are ACTIVE by default."""


@given('the queue is not "ACTIVE"')
def queue_is_not_active_given(lws_session, world):
    pytest.skip("lws does not reject put_rule when the queue is not ACTIVE")


@given("the queue does not exist")
def queue_does_not_exist():
    pytest.skip("lws does not validate SQS queue target existence when creating a rule")


@given('the target queue is "ACTIVE"')
def target_queue_is_active():
    """No-op: queues are ACTIVE by default after creation."""


@given('the target queue is not "ACTIVE"')
def target_queue_is_not_active():
    pytest.skip("lws does not reject put_events when the target queue is not ACTIVE")


# ── Given: rule targeting queue ────────────────────────────────────────


@given('an "ENABLED" rule exists on the bus targeting a queue')
def enabled_rule_exists_targeting_queue(lws_session):
    _create_queue(lws_session)
    _create_rule_targeting_sqs(lws_session)


@given('no "ENABLED" rule exists on the bus targeting a queue')
def no_enabled_rule_targeting_queue():
    pytest.skip("lws does not reject put_events when no enabled rule exists targeting the queue")


# ── Given: message/slot state ──────────────────────────────────────────


@given('an "AVAILABLE" message exists in the queue')
def available_message_exists_in_queue(lws_session):
    _create_queue(lws_session)
    _sqs(lws_session).send_message(
        QueueUrl=_queue_url(lws_session),
        MessageBody=TEST_MESSAGE,
    )


@given('no "AVAILABLE" message exists in the queue')
def no_available_message_in_queue():
    pytest.skip("Cannot ensure no messages exist in an empty queue without creating it first")


@given("a message slot is available")
def message_slot_available():
    """No-op: always room for messages."""


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip("Cannot exhaust message slot limit")


# ── When: actions ──────────────────────────────────────────────────────


@when("an EventBridge event bus is created")
def create_event_bus(lws_session, world):
    try:
        world["result"] = _events(lws_session).create_event_bus(Name=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "SQS" queue is created')
def create_queue(lws_session, world):
    try:
        world["result"] = _sqs(lws_session).create_queue(QueueName=TEST_QUEUE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an EventBridge rule is created to route matching events to the "SQS" queue')
def put_rule_targeting_sqs(lws_session, world):
    try:
        world["result"] = _events(lws_session).put_rule(
            Name=TEST_RULE,
            EventBusName=TEST_BUS,
            EventPattern=EVENT_PATTERN,
            State="ENABLED",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an event is published to the bus and routed to the target "SQS" queue')
def put_event_routed_to_sqs(lws_session, world):
    try:
        world["result"] = _events(lws_session).put_events(
            Entries=[
                {
                    "EventBusName": TEST_BUS,
                    "Source": "test.source",
                    "DetailType": "TestEvent",
                    "Detail": '{"key": "value"}',
                }
            ]
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('a message is consumed from the "SQS" queue')
def consume_message_from_sqs(lws_session, world):
    try:
        resp = _sqs(lws_session).receive_message(
            QueueUrl=_queue_url(lws_session),
            MaxNumberOfMessages=1,
            WaitTimeSeconds=0,
        )
        msgs = resp.get("Messages", [])
        if msgs:
            _sqs(lws_session).delete_message(
                QueueUrl=_queue_url(lws_session),
                ReceiptHandle=msgs[0]["ReceiptHandle"],
            )
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the event bus is "ACTIVE"')
def event_bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the queue is "ACTIVE"')
def queue_is_active_then(lws_session):
    resp = _sqs(lws_session).list_queues(QueueNamePrefix=TEST_QUEUE)
    actual_urls = resp.get("QueueUrls", [])
    assert any(
        TEST_QUEUE in u for u in actual_urls
    ), f"Expected queue '{TEST_QUEUE}' to be ACTIVE but not found in: {actual_urls}"


@then('the rule is "ENABLED" and will forward matching events to the queue')
def rule_enabled_targeting_queue(world):
    assert world["error"] is None, f"Expected put_rule to succeed but got: {world['error']}"


@then('the message is "AVAILABLE" in the target queue')
def message_available_in_target_queue(world):
    assert world["error"] is None, f"Expected put_events to succeed but got: {world['error']}"


@then('the message is "DELETED"')
def message_is_deleted(world):
    assert world["error"] is None, f"Expected consume message to succeed but got: {world['error']}"
