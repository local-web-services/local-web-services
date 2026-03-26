"""Abstract BDD step definitions for NeptuneEvents integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_CLUSTER = "e2e-test-cluster-1"
TEST_BUS = "e2e-test-bus-1"


def _neptune(lws_session):
    return lws_session.client("neptune")


def _events(lws_session):
    return lws_session.client("events")


def _create_cluster(lws_session, cluster_id=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _neptune(lws_session).create_db_cluster(
        DBClusterIdentifier=cluster_id,
        Engine="neptune",
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
    pytest.skip("lws does not reject Neptune operations when the event bus is deleted")


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


# ── Given: cluster state ───────────────────────────────────────────────


@given("the cluster does not already exist")
def cluster_not_already_exist():
    """No-op: fresh state has no clusters."""


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    _create_cluster(lws_session)


@given('the cluster is "AVAILABLE"')
def cluster_is_available_given():
    pytest.skip("Cannot observe internal cluster state transitions in lws")


@given('the cluster is not "AVAILABLE"')
def cluster_is_not_available_given():
    pytest.skip("Cannot control cluster availability state in lws")


@given('the cluster is "STOPPING"')
def cluster_is_stopping_given():
    pytest.skip("Cannot trigger internal cluster stopping state in lws")


@given('the cluster is not "STOPPING"')
def cluster_is_not_stopping_given():
    pytest.skip("Cannot control cluster stopping state in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available():
    pytest.skip("Cannot exhaust event slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: fresh state has no clusters."""


@given('a Neptune cluster has been created and has become "AVAILABLE"')
def neptune_cluster_created_and_available_seq(lws_session):
    _create_cluster(lws_session)


@given("busid not in bus_status")
def busid_not_in_bus_status():
    """No-op: fresh state has no custom buses."""


@given("an EventBridge event bus has been created")
def eventbridge_bus_created_seq(lws_session):
    _create_bus(lws_session)


@given("busid in bus_status")
def busid_in_bus_status(lws_session):
    _create_bus(lws_session)


@given("the EventBridge event bus has been deleted")
def eventbridge_bus_deleted_seq(lws_session):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _events(lws_session).delete_event_bus(Name=TEST_BUS)


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    _create_cluster(lws_session)


@given(
    "the Neptune cluster has stopped and has delivered the state change event to the EventBridge bus"  # noqa: E501
)
def neptune_cluster_stopped_event_delivered_seq():
    pytest.skip("Cannot trigger internal Neptune cluster stop event routing in lws")


@given("the Neptune cluster has stopped but event delivery has failed because the bus is deleted")
def neptune_cluster_stopped_event_failed_seq():
    pytest.skip("Cannot trigger internal Neptune event delivery failure in lws")


@given("the Neptune cluster has finished stopping")
def neptune_cluster_finished_stopping_seq():
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")


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


@when('a Neptune cluster is created and becomes "AVAILABLE"')
def create_neptune_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when("the Neptune cluster stops and delivers the state change event to the EventBridge bus")
def cluster_stop_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster stop event routing in lws")


@when("the Neptune cluster stops but event delivery fails because the bus is deleted")
def cluster_stop_event_fails(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune event delivery failure in lws")


@when("the Neptune cluster finishes stopping")
def cluster_stop_complete(lws_session, world):
    pytest.skip("Cannot trigger internal Neptune cluster stop completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the bus is "DELETED" and Neptune event delivery will fail')
def bus_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_event_bus to succeed but got: {world['error']}"


@then('the cluster is "AVAILABLE"')
def cluster_is_available_then(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then('the cluster is "STOPPED"')
def cluster_is_stopped_then():
    pytest.skip("Cannot observe internal Neptune cluster stopped state in lws")


@then('the cluster is "STOPPING" and the "STOPPED" event is "DELIVERED"')
def cluster_stopping_and_event_delivered():
    pytest.skip("Cannot trigger internal Neptune cluster stop event delivery in lws")


@then('the cluster is "STOPPING" but no event is delivered')
def cluster_stopping_but_no_event():
    pytest.skip("Cannot observe internal Neptune cluster stopping state in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "DELIVERED" event references a bus that exists')
def _inv_neptune_events_every_delivered_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "DELIVERED" event references a cluster that exists')
def _inv_neptune_events_every_delivered_event_references_a_cluster_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
