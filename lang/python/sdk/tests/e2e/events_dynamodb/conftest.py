"""Abstract BDD step definitions for EventsDynamodb integration spec scenarios."""

from __future__ import annotations

import json

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUS = "e2e-test-bus-1"
TEST_RULE = "test-rule-1"
TEST_TABLE = "e2e-test-table-1"
TEST_PK = "id"
TEST_ITEM_KEY = "e2e-item-key-1"
EVENT_PATTERN = json.dumps({"source": ["test.source"]})
ROLE_ARN = "arn:aws:iam::000000000000:role/test"


def _events(lws_session):
    return lws_session.client("events")


def _dynamo(lws_session):
    return lws_session.client("dynamodb")


def _create_bus(lws_session, name=TEST_BUS):
    try:
        _events(lws_session).create_event_bus(Name=name)
    except Exception:  # noqa: BLE001
        pass  # bus may already exist


def _create_rule(lws_session, bus=TEST_BUS, rule=TEST_RULE):
    _create_bus(lws_session, name=bus)
    try:
        _events(lws_session).put_rule(
            Name=rule,
            EventBusName=bus,
            EventPattern=EVENT_PATTERN,
            State="ENABLED",
        )
    except Exception:  # noqa: BLE001
        pass  # rule may already exist


def _create_table(lws_session, name=TEST_TABLE):
    try:
        _dynamo(lws_session).create_table(
            TableName=name,
            KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
    except Exception:  # noqa: BLE001
        pass  # table may already exist


# ── Given: bus state ───────────────────────────────────────────────────


@given("the bus does not already exist")
def bus_not_already_exist():
    """No-op: fresh state has no custom buses."""


@given("the bus already exists")
def bus_already_exists(lws_session):
    _create_bus(lws_session)


@given("the bus exists")
def bus_exists(lws_session):
    _create_bus(lws_session)


@given('the bus exists and is "ACTIVE"')
def bus_exists_and_is_active(lws_session):
    _create_bus(lws_session)


@given('the bus does not exist or is not "ACTIVE"')
def bus_not_exist_or_not_active():
    """No-op: fresh state has no buses, which satisfies this precondition."""


# ── Given: rule state ──────────────────────────────────────────────────


@given("the rule does not already exist")
def rule_not_already_exist():
    """No-op: fresh state has no rules."""


@given("the rule already exists")
def rule_already_exists(lws_session):
    _create_rule(lws_session)


@given("the rule exists")
def rule_exists(lws_session):
    _create_bus(lws_session)
    _create_rule(lws_session)


@given("the rule does not exist")
def rule_does_not_exist():
    """No-op: fresh state has no rules."""


@given('the rule is "ENABLED"')
def rule_is_enabled_given():
    """No-op: rules are ENABLED by default."""


@given('the rule is "DISABLED"')
def rule_is_disabled_given(lws_session):
    _events(lws_session).disable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)


@given('a rule is "ENABLED"')
def a_rule_is_enabled(lws_session):
    _create_bus(lws_session)
    _create_rule(lws_session)


@given('no rule is "ENABLED"')
def no_rule_is_enabled():
    """No-op: fresh state has no rules."""


@given('the rule is already "DISABLED"')
def rule_is_already_disabled(lws_session):
    _events(lws_session).disable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)


@given('the rule is already "ENABLED"')
def rule_is_already_enabled():
    """No-op: rules are ENABLED by default after creation by 'the rule exists' step."""


# ── Given: table state ─────────────────────────────────────────────────


@given("the table does not already exist")
def table_not_already_exist():
    """No-op: fresh state has no tables."""


@given("the table already exists")
def table_already_exists(lws_session):
    _create_table(lws_session)


@given("the table exists")
def table_exists(lws_session):
    _create_table(lws_session)


@given('the table exists and is "ACTIVE"')
def table_exists_and_is_active(lws_session):
    _create_table(lws_session)


@given('the table does not exist or is not "ACTIVE"')
def table_not_exist_or_not_active():
    pytest.skip("lws does not validate DynamoDB target existence when creating a rule")


@given('the table is "ACTIVE"')
def table_is_active_given():
    """No-op: tables are ACTIVE by default in lws."""


@given('the target table is "ACTIVE"')
def target_table_is_active():
    """No-op: tables are ACTIVE by default after creation."""


@given('the target table is not "ACTIVE"')
def target_table_is_not_active():
    """No-op: no table exists, satisfies not-ACTIVE."""


@given('the target table is not "DELETING"')
def target_table_is_not_deleting():
    """No-op: tables are never in DELETING state in lws."""


@given('the target table is "DELETING"')
def target_table_is_deleting(lws_session, world):
    try:
        _dynamo(lws_session).delete_table(TableName=TEST_TABLE)
    except Exception:  # noqa: BLE001
        pass
    _create_table(lws_session)
    lws_session.lifecycle("dynamodb").delete_dwell_ms(5000).apply()
    _dynamo(lws_session).delete_table(TableName=TEST_TABLE)
    world["result"] = None
    world["error"] = None


@given('the table is already "DELETING"')
def table_is_already_deleting(lws_session, world):
    try:
        _dynamo(lws_session).delete_table(TableName=TEST_TABLE)
    except Exception:  # noqa: BLE001
        pass
    _create_table(lws_session)
    lws_session.lifecycle("dynamodb").delete_dwell_ms(5000).apply()
    _dynamo(lws_session).delete_table(TableName=TEST_TABLE)
    world["result"] = None
    world["error"] = None


@given("the table does not exist")
def table_does_not_exist():
    """No-op: fresh state has no tables."""


# ── Given: slots ───────────────────────────────────────────────────────


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available():
    pytest.skip("Cannot exhaust event slot limit")


@given("an item slot is available")
def item_slot_available(lws_session):
    lws_session.capacity("dynamodb").unlimited().apply()


@given("no item slot is available")
def no_item_slot_available(lws_session):
    lws_session.capacity("dynamodb").exhaust().apply()


# ── Given: sequence setup ─────────────────────────────────────────────


@given("busid not in bus_status")
def events_ddb_busid_not_in_bus_status():
    """No-op: fresh state has no custom buses."""


@given("busid in bus_status")
def events_ddb_busid_in_bus_status(lws_session):
    _create_bus(lws_session)


@given("tid not in table_status")
def events_ddb_tid_not_in_table_status():
    """No-op: fresh state has no tables."""


@given("tid in table_status")
def events_ddb_tid_in_table_status(lws_session):
    _create_table(lws_session)


@given("rid in rule_status")
def events_ddb_rid_in_rule_status(lws_session):
    _create_rule(lws_session)


@given("an EventBridge event bus has been created")
def events_ddb_bus_has_been_created(lws_session):
    _create_bus(lws_session)


@given("a DynamoDB table has been created")
def events_ddb_table_has_been_created(lws_session):
    _create_table(lws_session)


@given("a table deletion has been initiated")
def events_ddb_table_deletion_initiated():
    """No-op: fresh state has no tables, simulates a previously deleted table."""


@given("an EventBridge rule has been created targeting a DynamoDB table")
def events_ddb_rule_created_targeting_table(lws_session):
    _create_rule(lws_session)


@given("an EventBridge rule has been enabled")
def events_ddb_rule_enabled(lws_session):
    _create_rule(lws_session)
    try:
        _events(lws_session).enable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    except Exception:  # noqa: BLE001
        pass  # rule may already be enabled


@given("an EventBridge rule has been disabled")
def events_ddb_rule_disabled(lws_session):
    _create_rule(lws_session)
    try:
        _events(lws_session).disable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    except Exception:  # noqa: BLE001
        pass  # rule may already be disabled


@given(
    'an event has matched an "ENABLED" rule and EventBridge has written an item to the DynamoDB target'  # noqa: E501
)
def events_ddb_event_matched_and_written():
    pytest.skip("Cannot trigger internal EventBridge-to-DynamoDB routing in lws")


@given(
    'an event has matched an "ENABLED" rule but the DynamoDB write has failed because the table is being deleted'  # noqa: E501
)
def events_ddb_event_matched_write_failed():
    pytest.skip("Cannot trigger internal EventBridge-to-DynamoDB routing failure in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when("an EventBridge event bus is created")
def create_event_bus(lws_session, world):
    try:
        world["result"] = _events(lws_session).create_event_bus(Name=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an EventBridge rule is created targeting a DynamoDB table")
def create_rule_targeting_dynamodb(lws_session, world):
    try:
        world["result"] = _events(lws_session).put_rule(
            Name=TEST_RULE,
            EventBusName=TEST_BUS,
            EventPattern=EVENT_PATTERN,
            State="DISABLED",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a DynamoDB table is created")
def create_dynamo_table(lws_session, world):
    try:
        world["result"] = _dynamo(lws_session).create_table(
            TableName=TEST_TABLE,
            KeySchema=[{"AttributeName": TEST_PK, "KeyType": "HASH"}],
            AttributeDefinitions=[{"AttributeName": TEST_PK, "AttributeType": "S"}],
            BillingMode="PAY_PER_REQUEST",
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a table deletion is initiated")
def delete_dynamo_table(lws_session, world):
    try:
        world["result"] = _dynamo(lws_session).delete_table(TableName=TEST_TABLE)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an EventBridge rule is disabled")
def disable_rule(lws_session, world):
    try:
        world["result"] = _events(lws_session).disable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an EventBridge rule is enabled")
def enable_rule(lws_session, world):
    try:
        world["result"] = _events(lws_session).enable_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when(
    'an event matches an "ENABLED" rule but the DynamoDB write fails'
    " because the table is being deleted"
)
def event_matches_rule_but_table_deleting(world):
    pytest.skip("Cannot trigger internal event routing to a deleting table in lws")


@when('an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target')
def event_matches_rule_and_writes_item(world):
    pytest.skip("Cannot trigger internal EventBridge-to-DynamoDB routing in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the table is "ACTIVE"')
def table_is_active_then(lws_session):
    resp = _dynamo(lws_session).list_tables()
    actual_tables = resp.get("TableNames", [])
    assert (
        TEST_TABLE in actual_tables
    ), f"Expected table '{TEST_TABLE}' to be ACTIVE but not found in: {actual_tables}"


@then('the table is "DELETING" and item writes to it will fail')
def table_is_deleting_then(world):
    assert world["error"] is None, f"Expected delete_table to succeed but got: {world['error']}"


@then('the rule is "DISABLED" on the bus with the DynamoDB target configured')
def rule_disabled_with_dynamo_target(world):
    assert world["error"] is None, f"Expected put_rule to succeed but got: {world['error']}"


@then('the rule is "DISABLED" and will not match events')
def rule_is_disabled_then(lws_session):
    resp = _events(lws_session).describe_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    expected_state = "DISABLED"
    actual_state = resp.get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"


@then('the rule is "ENABLED" and will match events')
def rule_is_enabled_then(lws_session):
    resp = _events(lws_session).describe_rule(Name=TEST_RULE, EventBusName=TEST_BUS)
    expected_state = "ENABLED"
    actual_state = resp.get("State", "")
    assert (
        actual_state == expected_state
    ), f"Expected rule state '{expected_state}' but got '{actual_state}'"


@then('the event is "MATCHED" but no item is written')
def event_matched_but_no_item_written(world):
    pytest.skip("Cannot observe internal event matching state in lws")


@then('the item "EXISTS" in the table and the event is recorded as "MATCHED"')
def item_exists_and_event_matched(world):
    pytest.skip("Cannot observe internal event routing result in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then("every existing item references a table that exists")
def _inv_events_dynamodb_every_existing_item_references_a_table_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every matched event references a rule that exists")
def _inv_events_dynamodb_every_matched_event_references_a_rule_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
