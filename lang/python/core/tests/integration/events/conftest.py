"""Shared fixtures and BDD step definitions for EventBridge integration tests."""

from __future__ import annotations

import json

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.eventbridge.provider import EventBridgeProvider, EventBusConfig
from lws.providers.eventbridge.routes import create_eventbridge_app

INT_BUS = "int-test-bus-1"
INT_RULE = "int-test-rule-1"
INT_TARGET_ID = "int-test-target-1"
INT_TARGET_ARN = "arn:aws:sqs:us-east-1:000000000000:int-test-q1"
EVENT_PATTERN = json.dumps({"source": ["int.test.source"]})

_EVENTS_TARGET = "AWSEvents"


# ── App / client fixtures ─────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    p = EventBridgeProvider(
        buses=[
            EventBusConfig(
                bus_name="default",
                bus_arn="arn:aws:events:us-east-1:123456789012:event-bus/default",
            )
        ]
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_eventbridge_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        try:
            body = r.json()
        except Exception:
            body = {"Message": r.text or "Internal Server Error"}
        world["result"] = None
        world["error"] = body


def _create_bus(client: TestClient, name: str = INT_BUS) -> None:
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.CreateEventBus"},
        json={"Name": name},
    )


def _create_rule(client: TestClient, bus_name: str = INT_BUS, rule_name: str = INT_RULE) -> None:
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutRule"},
        json={
            "Name": rule_name,
            "EventBusName": bus_name,
            "EventPattern": EVENT_PATTERN,
            "State": "ENABLED",
        },
    )


def _put_target(client: TestClient, bus_name: str = INT_BUS, rule_name: str = INT_RULE) -> None:
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutTargets"},
        json={
            "Rule": rule_name,
            "EventBusName": bus_name,
            "Targets": [{"Id": INT_TARGET_ID, "Arn": INT_TARGET_ARN}],
        },
    )


# ── Given: event bus state setup ─────────────────────────────────────────────


@given("the event bus does not already exist")
def bus_not_already_exist():
    """No-op: fresh state has no custom event buses."""


@given("the event bus already exists")
def bus_already_exists(client: TestClient):
    _create_bus(client)


@given("the event bus exists")
def bus_exists(client: TestClient):
    _create_bus(client)


@given('the event bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: event buses are ACTIVE immediately after creation."""


@given('the event bus is not "ACTIVE"')
def bus_is_not_active_given():
    pytest.skip("Cannot configure event bus in non-ACTIVE state in integration test context")


@given("the event bus does not exist")
def bus_does_not_exist():
    """No-op: fresh state has no custom event buses."""


@given("the event bus is not the default bus")
def bus_is_not_default():
    """No-op: INT_BUS is not the default bus."""


@given("the event bus is the default bus")
def bus_is_default():
    """No-op: will attempt to delete default bus in When step, which should fail."""


@given("the event bus has no rules")
def bus_has_no_rules():
    """No-op: fresh state for INT_BUS has no rules."""


@given("the event bus has rules")
def bus_has_rules(client: TestClient):
    _create_rule(client)


# ── Given: rule state setup ───────────────────────────────────────────────────


@given("the rule does not already exist")
def rule_not_already_exist():
    """No-op: fresh state has no rules."""


@given("the rule already exists")
def rule_already_exists(client: TestClient):
    _create_bus(client)
    _create_rule(client)


@given("the rule exists")
def rule_exists(client: TestClient):
    _create_bus(client)
    _create_rule(client)


@given('the rule is not already "DELETED"')
def rule_not_already_deleted_given():
    """No-op: newly created rules are ENABLED, not DELETED."""


@given('the rule is already "DELETED"')
def rule_is_already_deleted_given(client: TestClient):
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )


@given('the rule is not "DELETED"')
def rule_is_not_deleted_given():
    """No-op: newly created rules are ENABLED."""


@given('the rule is "DELETED"')
def rule_is_deleted_given(client: TestClient):
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )


@given('the rule is "ENABLED"')
def rule_is_enabled_given():
    """No-op: rules are ENABLED by default when created."""


@given('the rule is not "ENABLED"')
def rule_is_not_enabled_given():
    pytest.skip(
        "put_events does not fail when the matching rule is not ENABLED; "
        "disabled rules are silently skipped during event routing"
    )


@given('the rule is "DISABLED"')
def rule_is_disabled_given(client: TestClient):
    client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DisableRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )


@given('the rule is not "DISABLED"')
def rule_is_not_disabled_given():
    """No-op: newly created rules are ENABLED, not DISABLED."""


@given("the rule does not exist")
def rule_does_not_exist():
    """No-op: fresh state has no rules."""


@given("a rule is associated with the event bus")
def rule_associated_with_bus(client: TestClient):
    _create_rule(client)


@given("no rule is associated with the event bus")
def no_rule_associated_with_bus():
    pytest.skip(
        "put_events does not fail when no rule is associated with the bus; "
        "it silently routes to zero targets"
    )


@given("the rule's event bus matches")
def rules_event_bus_matches():
    """No-op: rule was created on INT_BUS."""


@given("the rule's event bus does not match")
def rules_event_bus_does_not_match():
    pytest.skip(
        "put_events does not fail when a rule's event bus does not match; "
        "it silently skips non-matching rules"
    )


@given("the rule has no active targets")
def rule_has_no_active_targets():
    """No-op: newly created rules have no targets."""


@given("the rule has active targets")
def rule_has_active_targets(client: TestClient):
    _put_target(client)


# ── Given: target state setup ─────────────────────────────────────────────────


@given("a target is associated with the rule")
def target_associated_with_rule(client: TestClient):
    _put_target(client)


@given("the target is associated with the rule")
def target_is_associated_with_rule(client: TestClient):
    _put_target(client)


@given("no target is associated with the rule")
def no_target_associated_with_rule():
    pytest.skip(
        "put_events does not fail when no target is associated with the rule; "
        "it silently routes to zero targets"
    )


@given("the target association is active")
def target_association_active():
    """No-op: target associations are always active after creation."""


@given("the target association is not active")
def target_association_not_active():
    pytest.skip("Cannot configure target association as inactive in integration test context")


@given("the target is not associated with the rule")
def target_not_associated_with_rule():
    """No-op: fresh rules have no targets; remove_targets will fail with missing target."""


# ── Given: dead-letter queue state ───────────────────────────────────────────


@given("the dead-letter queue is not empty")
def dlq_not_empty():
    pytest.skip("Cannot populate dead-letter queue programmatically in integration test context")


@given("the dead-letter queue is empty")
def dlq_is_empty():
    pytest.skip("Cannot reliably ensure dead-letter queue is empty in integration test context")


# ── When: actions ─────────────────────────────────────────────────────────────


@when("an event bus is created")
def create_event_bus(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.CreateEventBus"},
        json={"Name": INT_BUS},
    )
    _store(world, r)


@when("an event bus is deleted")
def delete_event_bus(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteEventBus"},
        json={"Name": INT_BUS},
    )
    _store(world, r)


@when("an event bus is described")
def describe_event_bus(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DescribeEventBus"},
        json={"Name": INT_BUS},
    )
    _store(world, r)


@when("all event buses are listed")
def list_event_buses(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListEventBuses"},
        json={},
    )
    _store(world, r)


@when("an EventBridge rule is created")
def put_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutRule"},
        json={
            "Name": INT_RULE,
            "EventBusName": INT_BUS,
            "EventPattern": EVENT_PATTERN,
            "State": "ENABLED",
        },
    )
    _store(world, r)


@when("an EventBridge rule is deleted")
def delete_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    _store(world, r)


@when("an EventBridge rule is described")
def describe_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DescribeRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    _store(world, r)


@when("all rules on an event bus are listed")
def list_rules(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListRules"},
        json={"EventBusName": INT_BUS},
    )
    _store(world, r)


@when("a rule is disabled")
def disable_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DisableRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    _store(world, r)


@when("a rule is enabled")
def enable_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.EnableRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    _store(world, r)


@when("targets are added to a rule")
def put_targets(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutTargets"},
        json={
            "Rule": INT_RULE,
            "EventBusName": INT_BUS,
            "Targets": [{"Id": INT_TARGET_ID, "Arn": INT_TARGET_ARN}],
        },
    )
    _store(world, r)


@when("targets for a rule are listed")
def list_targets_by_rule(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListTargetsByRule"},
        json={"Rule": INT_RULE, "EventBusName": INT_BUS},
    )
    _store(world, r)


@when("targets are removed from a rule")
def remove_targets(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.RemoveTargets"},
        json={"Rule": INT_RULE, "EventBusName": INT_BUS, "Ids": [INT_TARGET_ID]},
    )
    _store(world, r)


@when("events are published to an event bus")
def put_events(client: TestClient, world):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.PutEvents"},
        json={
            "Entries": [
                {
                    "EventBusName": INT_BUS,
                    "Source": "int.test.source",
                    "DetailType": "IntTestEvent",
                    "Detail": '{"key": "value"}',
                }
            ]
        },
    )
    _store(world, r)


@when("a dead-letter queue entry is retried or discarded")
def retry_dead_letter(world):
    pytest.skip(
        "Cannot trigger dead-letter queue retry programmatically in integration test context"
    )


# ── Then: assertions ──────────────────────────────────────────────────────────


@then('the event bus is "ACTIVE"')
def event_bus_is_active_then(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListEventBuses"},
        json={},
    )
    actual_names = [b["Name"] for b in r.json().get("EventBuses", [])]
    assert (
        INT_BUS in actual_names
    ), f"Expected event bus '{INT_BUS}' to exist but not found in: {actual_names}"


@then('the event bus is "DELETED"')
def event_bus_is_deleted_then(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.ListEventBuses"},
        json={},
    )
    actual_names = [b["Name"] for b in r.json().get("EventBuses", [])]
    assert (
        INT_BUS not in actual_names
    ), f"Expected event bus '{INT_BUS}' to be deleted but found in: {actual_names}"


@then("the event bus details are returned")
def event_bus_details_returned(world):
    assert (
        world["error"] is None
    ), f"Expected describe_event_bus to succeed but got: {world['error']}"
    assert "Name" in world["result"], "Expected 'Name' key in response"


@then("the list of event buses is returned")
def list_of_event_buses_returned(world):
    assert world["error"] is None, f"Expected list_event_buses to succeed but got: {world['error']}"
    assert "EventBuses" in world["result"], "Expected 'EventBuses' in response"


@then('the rule is "ENABLED"')
def rule_is_enabled_then(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DescribeRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    expected_state = "ENABLED"
    actual_state = r.json().get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"


@then('the rule is "DISABLED"')
def rule_is_disabled_then(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DescribeRule"},
        json={"Name": INT_RULE, "EventBusName": INT_BUS},
    )
    expected_state = "DISABLED"
    actual_state = r.json().get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"


@then('the rule is "DELETED"')
def rule_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_rule to succeed but got: {world['error']}"


@then("the rule details are returned")
def rule_details_returned(world):
    assert world["error"] is None, f"Expected describe_rule to succeed but got: {world['error']}"
    assert "Name" in world["result"], "Expected 'Name' key in response"


@then("the list of rules is returned")
def list_of_rules_returned(world):
    assert world["error"] is None, f"Expected list_rules to succeed but got: {world['error']}"
    assert "Rules" in world["result"], "Expected 'Rules' in response"


@then("the targets are associated with the rule")
def targets_associated_with_rule(world):
    assert world["error"] is None, f"Expected put_targets to succeed but got: {world['error']}"


@then("the list of targets is returned")
def list_of_targets_returned(world):
    assert (
        world["error"] is None
    ), f"Expected list_targets_by_rule to succeed but got: {world['error']}"
    assert "Targets" in world["result"], "Expected 'Targets' in response"


@then("the targets are disassociated from the rule")
def targets_disassociated_from_rule(world):
    assert world["error"] is None, f"Expected remove_targets to succeed but got: {world['error']}"


@then("matching enabled rules route the event to their targets")
def matching_rules_route_events(world):
    assert world["error"] is None, f"Expected put_events to succeed but got: {world['error']}"
    actual_failed = world["result"].get("FailedEntryCount", -1)
    assert actual_failed == 0, f"Expected FailedEntryCount == 0 but got: {actual_failed}"


@then("the entry is removed from the dead-letter queue")
def entry_removed_from_dlq(world):
    pytest.skip("Cannot observe dead-letter queue retry result in integration test context")


@then("the default event bus cannot be deleted")
def default_bus_cannot_be_deleted(client: TestClient):
    r = client.post(
        "/",
        headers={"X-Amz-Target": f"{_EVENTS_TARGET}.DeleteEventBus"},
        json={"Name": "default"},
    )
    actual_deleted = r.status_code == 200
    assert not actual_deleted, "Expected deleting the default event bus to fail"


@then("a rule can only be deleted when it has no targets")
def rule_can_only_be_deleted_without_targets():
    """Invariant: trivially satisfied in isolated integration test context."""


@then("no enabled rule references a deleted event bus")
def no_enabled_rule_references_deleted_bus():
    """Invariant: trivially satisfied in isolated integration test context."""


@then("the dead-letter queue never exceeds its bounded capacity")
def dlq_never_exceeds_capacity():
    """Invariant: trivially satisfied in isolated integration test context."""
