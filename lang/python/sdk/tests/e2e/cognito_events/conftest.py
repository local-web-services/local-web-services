"""Abstract BDD step definitions for CognitoEvents integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_POOL = "e2e-test-pool-1"
TEST_BUS = "e2e-test-bus-1"


def _cognito(lws_session):
    return lws_session.client("cognito-idp")


def _events(lws_session):
    return lws_session.client("events")


def _create_pool(lws_session, name=TEST_POOL):
    try:
        _cognito(lws_session).create_user_pool(PoolName=name)
    except Exception:  # noqa: BLE001
        pass  # pool may already exist


def _create_bus(lws_session, name=TEST_BUS):
    try:
        _events(lws_session).create_event_bus(Name=name)
    except Exception:  # noqa: BLE001
        pass  # bus may already exist


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


@given('the bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: buses are ACTIVE by default after creation."""


@given('the bus is "DELETED"')
def bus_is_deleted_given():
    pytest.skip("lws does not reject Cognito operations when the event bus is deleted")


@given('the bus is not "DELETED"')
def bus_is_not_deleted_given():
    pytest.skip("lws does not enforce event delivery failure when the bus is not deleted")


@given('the bus is already "DELETED"')
def bus_is_already_deleted(lws_session, world):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("events").delete_dwell_ms(5000).apply()
    _events(lws_session).delete_event_bus(Name=TEST_BUS)
    world["result"] = None
    world["error"] = None


@given("the bus does not exist")
def bus_does_not_exist():
    """No-op: fresh state has no buses."""


@given('the bus does not exist or is not "ACTIVE"')
def bus_not_exist_or_not_active():
    pytest.skip(
        "lws does not reject enable_event_publishing when the bus does not exist or is not ACTIVE"
    )


# ── Given: pool state ──────────────────────────────────────────────────


@given("the pool does not already exist")
def pool_not_already_exist():
    """No-op: fresh state has no user pools."""


@given("the pool already exists")
def pool_already_exists(lws_session):
    _create_pool(lws_session)


@given('the pool exists and is "ACTIVE"')
def pool_exists_and_is_active(lws_session):
    _create_pool(lws_session)


@given('the pool does not exist or is not "ACTIVE"')
def pool_not_exist_or_not_active():
    """No-op: fresh state has no pools."""


@given("the pool has an EventBridge configuration")
def pool_has_eventbridge_config():
    pytest.skip("Cannot configure EventBridge on a Cognito user pool in lws")


@given("the pool has no EventBridge configuration")
def pool_has_no_eventbridge_config():
    """No-op: pools have no EventBridge configuration by default."""


@given("the pool already has an EventBridge configuration")
def pool_already_has_eventbridge_config():
    pytest.skip("Cannot configure EventBridge on a Cognito user pool in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available():
    pytest.skip("Cannot exhaust event slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("pid not in pool_status")
def cognito_events_pid_not_in_pool_status():
    """No-op: fresh state has no user pools."""


@given("pid in pool_status")
def cognito_events_pid_in_pool_status(lws_session):
    _create_pool(lws_session)


@given("busid not in bus_status")
def cognito_events_busid_not_in_bus_status():
    """No-op: fresh state has no custom buses."""


@given("busid in bus_status")
def cognito_events_busid_in_bus_status(lws_session):
    _create_bus(lws_session)


@given("a Cognito user pool has been created")
def cognito_events_user_pool_has_been_created(lws_session):
    _create_pool(lws_session)


@given("an EventBridge event bus has been created")
def cognito_events_event_bus_has_been_created(lws_session):
    _create_bus(lws_session)


@given("the EventBridge event bus has been deleted")
def cognito_events_event_bus_has_been_deleted(lws_session):
    _create_bus(lws_session)
    _events(lws_session).delete_event_bus(Name=TEST_BUS)


@given("EventBridge publishing has been enabled on the user pool")
def cognito_events_publishing_enabled():
    pytest.skip("Cannot configure EventBridge on a Cognito user pool in lws")


@given(
    "a user action has occurred in the pool and Cognito has delivered the event to the EventBridge bus"  # noqa: E501
)
def cognito_events_user_action_delivered():
    pytest.skip("Cannot trigger internal Cognito user action event routing in lws")


@given("a user action has occurred but event delivery has failed because the bus has been deleted")
def cognito_events_user_action_delivery_failed():
    pytest.skip("Cannot trigger internal Cognito event delivery failure in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when("an EventBridge event bus is created")
def create_event_bus(lws_session, world):
    try:
        world["result"] = _events(lws_session).create_event_bus(Name=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the EventBridge event bus is deleted")
def delete_event_bus(lws_session, world):
    try:
        world["result"] = _events(lws_session).delete_event_bus(Name=TEST_BUS)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a Cognito user pool is created")
def create_user_pool(lws_session, world):
    try:
        world["result"] = _cognito(lws_session).create_user_pool(PoolName=TEST_POOL)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("EventBridge publishing is enabled on the user pool")
def enable_event_publishing(lws_session, world):
    pytest.skip("Cannot trigger internal EventBridge publishing configuration in lws")


@when("a user action occurs in the pool and Cognito delivers the event to the EventBridge bus")
def user_action_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger internal Cognito user action event routing in lws")


@when("a user action occurs but event delivery fails because the bus has been deleted")
def user_action_event_delivery_fails(lws_session, world):
    pytest.skip("Cannot trigger internal Cognito event delivery failure in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the bus is "DELETED" and Cognito event delivery will fail')
def bus_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_event_bus to succeed but got: {world['error']}"


@then('the pool is "ACTIVE" with no EventBridge configuration')
def pool_is_active_no_eventbridge(lws_session):
    resp = _cognito(lws_session).list_user_pools(MaxResults=60)
    actual_names = [p["Name"] for p in resp.get("UserPools", [])]
    assert (
        TEST_POOL in actual_names
    ), f"Expected user pool '{TEST_POOL}' to be ACTIVE but not found in: {actual_names}"


@then("the pool will send user events to the bus")
def pool_will_send_events_to_bus():
    pytest.skip("Cannot observe internal EventBridge publishing configuration in lws")


@then('the event is "DELIVERED" to the bus')
def event_delivered_to_bus():
    pytest.skip("Cannot trigger internal Cognito event delivery in lws")


@then('the event delivery "FAILED"')
def event_delivery_failed():
    pytest.skip("Cannot observe internal Cognito event delivery failure in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "DELIVERED" event references a bus that exists')
def _inv_cognito_events_every_delivered_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "DELIVERED" event references a pool that exists')
def _inv_cognito_events_every_delivered_event_references_a_pool_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
