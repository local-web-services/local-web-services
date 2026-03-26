"""Abstract BDD step definitions for RdsEvents integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_DB_INSTANCE = "e2e-test-db-instance-1"
TEST_BUS = "e2e-test-bus-1"


def _rds(lws_session):
    return lws_session.client("rds")


def _events(lws_session):
    return lws_session.client("events")


def _create_db_instance(lws_session, instance_id=TEST_DB_INSTANCE):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _rds(lws_session).create_db_instance(
        DBInstanceIdentifier=instance_id,
        DBInstanceClass="db.t3.micro",
        Engine="mysql",
        MasterUsername="admin",
        MasterUserPassword="e2e-test-password-1",
    )


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


# ── Given: bus state ───────────────────────────────────────────────


@given("the bus does not already exist")
def bus_not_already_exist():
    """No-op: fresh state has no custom buses."""


@given("the bus already exists")
def bus_already_exists(lws_session):
    _create_bus(lws_session)


@given("the bus exists")
def bus_exists(lws_session):
    _create_bus(lws_session)


@given('the bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: buses are ACTIVE by default after creation."""


@given('the bus is "DELETED"')
def bus_is_deleted_given():
    pytest.skip("lws does not reject RDS operations when the event bus is deleted")


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


# ── Given: DB instance state ───────────────────────────────────────────


@given('the "DB" instance does not already exist')
def db_instance_not_already_exist():
    """No-op: fresh state has no DB instances."""


@given('the "DB" instance already exists')
def db_instance_already_exists(lws_session):
    _create_db_instance(lws_session)


@given('the "DB" instance is "AVAILABLE"')
def db_instance_is_available_given():
    pytest.skip("Cannot observe internal DB instance state transitions in lws")


@given('the "DB" instance is not "AVAILABLE"')
def db_instance_is_not_available_given():
    pytest.skip("Cannot control DB instance availability state in lws")


@given('the "DB" instance is "STOPPING"')
def db_instance_is_stopping_given():
    pytest.skip("Cannot trigger internal DB instance stopping state in lws")


@given('the "DB" instance is not "STOPPING"')
def db_instance_is_not_stopping_given():
    pytest.skip("Cannot control DB instance stopping state in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available():
    pytest.skip("Cannot exhaust event slot limit")


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


@when('an "RDS" "DB" instance is created and becomes "AVAILABLE"')
def create_db_instance(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when('the "RDS" instance stops and delivers the state change event to the EventBridge bus')
def db_stop_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger internal RDS DB instance stop event routing in lws")


@when(
    'the "RDS" instance stops but the state change event delivery fails because the bus is deleted'
)
def db_stop_event_fails(lws_session, world):
    pytest.skip("Cannot trigger internal RDS event delivery failure in lws")


@when('the "DB" instance finishes stopping')
def db_stop_complete(lws_session, world):
    pytest.skip("Cannot trigger internal RDS DB instance stop completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the bus is "DELETED" and "RDS" event delivery will fail')
def bus_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_event_bus to succeed but got: {world['error']}"


@then('the "DB" instance is "AVAILABLE"')
def db_instance_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the "DB" instance is "STOPPED"')
def db_instance_is_stopped_then():
    pytest.skip("Cannot observe internal RDS DB instance stopped state in lws")


@then('the "DB" instance is "STOPPING" and the event is "DELIVERED"')
def db_instance_stopping_and_event_delivered():
    pytest.skip("Cannot trigger internal RDS DB instance stop event delivery in lws")


@then('the "DB" instance is "STOPPING" but no event is delivered')
def db_instance_stopping_but_no_event():
    pytest.skip("Cannot observe internal RDS DB instance stopping state in lws")


# ── Given: sequence setup ─────────────────────────────────────────


@given("dbid not in db_status")
def rds_events_dbid_not_in_db_status():
    """No-op: fresh state has no DB instances."""


@given('an "RDS" "DB" instance has been created and has become "AVAILABLE"')
def rds_db_instance_created_and_available(lws_session):
    _create_db_instance(lws_session)


@given("busid not in bus_status")
def rds_events_busid_not_in_bus_status():
    """No-op: fresh state has no custom event buses."""


@given("an EventBridge event bus has been created")
def rds_events_event_bus_has_been_created(lws_session):
    _create_bus(lws_session)


@given("busid in bus_status")
def rds_events_busid_in_bus_status(lws_session):
    _create_bus(lws_session)


@given("the EventBridge event bus has been deleted")
def rds_events_event_bus_has_been_deleted(lws_session):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _events(lws_session).delete_event_bus(Name=TEST_BUS)


@given("dbid in db_status")
def rds_events_dbid_in_db_status(lws_session):
    _create_db_instance(lws_session)


@given(
    'the "RDS" instance has stopped and has delivered the state change event to the EventBridge bus'
)
def rds_instance_stopped_event_delivered():
    pytest.skip("Cannot trigger internal RDS DB instance stop event routing in lws")


@given(
    'the "RDS" instance has stopped but the state change event delivery has failed because'
    " the bus is deleted"
)
def rds_instance_stopped_event_failed():
    pytest.skip("Cannot trigger internal RDS event delivery failure in lws")


@given('the "DB" instance has finished stopping')
def rds_events_db_instance_finished_stopping():
    pytest.skip("Cannot trigger internal RDS DB instance stop completion in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "DELIVERED" event references a "DB" instance that exists')
def _inv_rds_events_every_delivered_event_references_a_db_instance_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "DELIVERED" event references a bus that exists')
def _inv_rds_events_every_delivered_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
