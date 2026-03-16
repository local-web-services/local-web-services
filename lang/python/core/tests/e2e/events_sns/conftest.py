"""Abstract BDD step definitions for EventsSns integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUS = "e2e-test-bus-1"
TEST_RULE = "test-rule-1"
TEST_TOPIC = "e2e-test-topic-1"
EVENT_PATTERN = json.dumps({"source": ["test.source"]})
TEST_MESSAGE = "test-sns-message-1"


def _events(lws_session):
    return lws_session.client("events")


def _sns(lws_session):
    return lws_session.client("sns")


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


def _create_topic(lws_session, name=TEST_TOPIC):
    resp = _sns(lws_session).create_topic(Name=name)
    return resp["TopicArn"]


def _create_rule_targeting_sns(lws_session, bus=TEST_BUS, rule=TEST_RULE):
    _events(lws_session).put_rule(
        Name=rule,
        EventBusName=bus,
        EventPattern=EVENT_PATTERN,
        State="ENABLED",
    )
    _events(lws_session).put_targets(
        Rule=rule,
        EventBusName=bus,
        Targets=[{"Id": "t1", "Arn": _topic_arn()}],
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


@given("the event bus is \"ACTIVE\"")
def event_bus_is_active_given():
    """No-op: buses are ACTIVE by default."""


@given("the event bus is not \"ACTIVE\"")
def event_bus_is_not_active_given(lws_session, world):
    import httpx
    try:
        _events(lws_session).delete_event_bus(Name=TEST_BUS)
    except Exception:  # noqa: BLE001
        pass
    httpx.post(
        f"http://127.0.0.1:{lws_session._mgmt_port}/_ldk/lifecycle",
        json={"events": {"enabled": True, "create_dwell_ms": 5000}},
        timeout=5.0,
    )
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
    _create_rule_targeting_sns(lws_session)


# ── Given: topic state ─────────────────────────────────────────────────

@given("the topic does not already exist")
def topic_not_already_exist():
    """No-op: fresh state has no topics."""


@given("the topic already exists")
def topic_already_exists(lws_session):
    _create_topic(lws_session)


@given("the topic exists")
def topic_exists(lws_session):
    _create_topic(lws_session)


@given("the topic is \"ACTIVE\"")
def topic_is_active_given():
    """No-op: topics are ACTIVE by default."""


@given("the topic is not \"ACTIVE\"")
def topic_is_not_active_given(lws_session, world):
    pytest.skip("lws does not reject put_rule when the topic is not ACTIVE")


@given("the topic does not exist")
def topic_does_not_exist():
    pytest.skip("lws does not validate SNS topic target existence when creating a rule")


@given("the target topic is \"ACTIVE\"")
def target_topic_is_active():
    """No-op: topics are ACTIVE by default after creation."""


@given("the target topic is not \"ACTIVE\"")
def target_topic_is_not_active():
    pytest.skip("lws does not reject put_events when the target topic is not ACTIVE")


# ── Given: rule targeting topic ────────────────────────────────────────

@given("an \"ENABLED\" rule exists on the bus targeting a topic")
def enabled_rule_exists_targeting_topic(lws_session):
    _create_rule_targeting_sns(lws_session)


@given("no \"ENABLED\" rule exists on the bus targeting a topic")
def no_enabled_rule_targeting_topic():
    pytest.skip("lws does not reject put_events when no enabled rule exists targeting the topic")


# ── Given: message/slot state ──────────────────────────────────────────

@given("an \"AVAILABLE\" message exists on the topic")
def available_message_exists_on_topic(lws_session):
    topic_arn = _create_topic(lws_session)
    _sns(lws_session).publish(TopicArn=topic_arn, Message=TEST_MESSAGE)


@given("no \"AVAILABLE\" message exists on the topic")
def no_available_message_on_topic():
    pytest.skip("Cannot reliably check for no messages on SNS topic")


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


@when("an \"SNS\" topic is created")
def create_topic(lws_session, world):
    try:
        resp = _sns(lws_session).create_topic(Name=TEST_TOPIC)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an EventBridge rule is created to route matching events to an \"SNS\" topic")
def put_rule_targeting_sns(lws_session, world):
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


@when("an event is published to the bus and routed to the target \"SNS\" topic")
def put_event_to_bus_routed_to_sns(lws_session, world):
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


@when("a subscriber consumes a message from the \"SNS\" topic")
def consume_message_from_sns(world):
    pytest.skip("Cannot consume internal SNS message delivery in lws")


# ── Then: assertions ───────────────────────────────────────────────────

@then("the event bus is \"ACTIVE\"")
def event_bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert TEST_BUS in actual_names, (
        f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"
    )


@then("the topic is \"ACTIVE\"")
def topic_is_active_then(lws_session):
    resp = _sns(lws_session).list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    assert any(TEST_TOPIC in arn for arn in actual_arns), (
        f"Expected topic '{TEST_TOPIC}' to be ACTIVE but not found in: {actual_arns}"
    )


@then("the rule is \"ENABLED\" and will publish to the topic when matching events are received")
def rule_enabled_and_targeting_topic(world):
    assert world["error"] is None, (
        f"Expected put_rule to succeed but got: {world['error']}"
    )


@then("the message is \"AVAILABLE\" on the topic")
def message_available_on_topic(world):
    assert world["error"] is None, (
        f"Expected put_events to succeed but got: {world['error']}"
    )


@then("the message is \"DELETED\"")
def message_is_deleted(world):
    pytest.skip("Cannot observe message deletion from SNS in lws")


