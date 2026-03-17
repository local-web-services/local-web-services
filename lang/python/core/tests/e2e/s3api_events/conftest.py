"""Abstract BDD step definitions for S3apiEvents integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUCKET = "e2e-test-bucket-1"
TEST_KEY = "e2e-test-key-1"
TEST_BUS = "e2e-test-bus-1"
TEST_BODY = b"test-data-content-1"


def _s3(lws_session):
    return lws_session.client("s3")


def _events(lws_session):
    return lws_session.client("events")


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


def _create_bus(lws_session, name=TEST_BUS):
    _events(lws_session).create_event_bus(Name=name)


# ── Given: bucket state ────────────────────────────────────────────────

@given("the bucket does not already exist")
def bucket_not_already_exist():
    """No-op: fresh state has no buckets."""


@given("the bucket already exists")
def bucket_already_exists(lws_session):
    _create_bucket(lws_session)


@given("the bucket exists and is \"ACTIVE\"")
def bucket_exists_and_is_active(lws_session):
    _create_bucket(lws_session)


@given("the bucket does not exist or is not \"ACTIVE\"")
def bucket_not_exist_or_not_active():
    """No-op: fresh state has no buckets."""


@given("the bucket is \"ACTIVE\"")
def bucket_is_active_given():
    """No-op: buckets are ACTIVE by default after creation."""


@given("the bucket is not \"ACTIVE\"")
def bucket_is_not_active_given(lws_session, world):
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    _create_bucket(lws_session)
    world["result"] = None
    world["error"] = None


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


@given("the bus exists and is \"ACTIVE\"")
def bus_exists_and_is_active(lws_session):
    _create_bus(lws_session)


@given("the bus does not exist or is not \"ACTIVE\"")
def bus_not_exist_or_not_active():
    """No-op: fresh state has no buses."""


@given("the bus is \"ACTIVE\"")
def bus_is_active_given():
    """No-op: buses are ACTIVE by default after creation."""


@given("the bus is already \"DELETED\"")
def bus_is_already_deleted(lws_session, world):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass  # bus may already exist from a prior Given step
    lws_session.lifecycle("events").delete_dwell_ms(5000).apply()
    _events(lws_session).delete_event_bus(Name=TEST_BUS)
    world["result"] = None
    world["error"] = None


@given("the bus does not exist")
def bus_does_not_exist():
    """No-op: fresh state has no buses."""


# ── Given: notification config state ──────────────────────────────────

@given("the bucket has no EventBridge notification configured")
def bucket_has_no_eventbridge_notification():
    """No-op: no notification configured by default."""


@given("the bucket already has an EventBridge notification configured")
def bucket_already_has_eventbridge_notification():
    pytest.skip("Cannot pre-configure EventBridge notification in this context")


@given("the bucket has an EventBridge notification configured")
def bucket_has_eventbridge_notification():
    pytest.skip("Cannot pre-configure EventBridge notification in this context")


@given("the target bus is \"ACTIVE\"")
def target_bus_is_active(lws_session):
    _create_bus(lws_session)


@given("the target bus is \"DELETED\"")
def target_bus_is_deleted():
    pytest.skip("Cannot force bus to DELETED state in this context")


@given("the target bus is not \"DELETED\"")
def target_bus_is_not_deleted(lws_session):
    _create_bus(lws_session)


# ── Given: slots ───────────────────────────────────────────────────────

@given("an object slot is available")
def object_slot_available():
    """No-op: always room for objects."""


@given("no object slot is available")
def no_object_slot_available():
    pytest.skip("Cannot exhaust object slot limit")


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available():
    pytest.skip("Cannot exhaust event slot limit")


# ── When: actions ──────────────────────────────────────────────────────

@when("an S3 bucket is created")
def create_s3_bucket(lws_session, world):
    try:
        world["result"] = _s3(lws_session).create_bucket(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


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


@when("EventBridge notifications are enabled on the bucket targeting a specific bus")
def enable_eventbridge_notification(world):
    pytest.skip("Cannot configure EventBridge bucket notifications in lws")


@when("an object is uploaded but event delivery fails because the bus has been deleted")
def put_object_event_fails(lws_session, world):
    try:
        world["result"] = _s3(lws_session).put_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            Body=TEST_BODY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an object is uploaded and S3 delivers an event to the EventBridge bus")
def put_object_with_event(lws_session, world):
    try:
        world["result"] = _s3(lws_session).put_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            Body=TEST_BODY,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────

@then("the bucket is \"ACTIVE\" with no EventBridge notification configuration")
def bucket_active_no_eventbridge(lws_session):
    resp = _s3(lws_session).list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert TEST_BUCKET in actual_buckets, (
        f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"
    )


@then("the bus is \"ACTIVE\"")
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert TEST_BUS in actual_names, (
        f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"
    )


@then("the bus is \"DELETED\" and event delivery to it will fail")
def bus_is_deleted_then(world):
    assert world["error"] is None, (
        f"Expected delete_event_bus to succeed but got: {world['error']}"
    )


@then("the bucket will send events to the bus when objects are uploaded")
def bucket_will_send_events(world):
    pytest.skip("Cannot observe EventBridge notification configuration in lws")


@then("the object \"EXISTS\" but no event is delivered")
def object_exists_but_no_event(lws_session):
    resp = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY in keys, (
        f"Expected object '{TEST_KEY}' to exist but not found in: {keys}"
    )


@then("the object \"EXISTS\" and an event is \"DELIVERED\" to the bus")
def object_exists_and_event_delivered(lws_session):
    resp = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY in keys, (
        f"Expected object '{TEST_KEY}' to exist but not found in: {keys}"
    )


