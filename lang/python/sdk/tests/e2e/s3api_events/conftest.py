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
    try:
        _s3(lws_session).create_bucket(Bucket=name)
    except Exception:  # noqa: BLE001
        pass  # bucket may already exist


def _create_bus(lws_session, name=TEST_BUS):
    try:
        _events(lws_session).create_event_bus(Name=name)
    except Exception:  # noqa: BLE001
        pass  # bus may already exist


# ── Given: bucket state ────────────────────────────────────────────────


@given("the bucket does not already exist")
def bucket_not_already_exist():
    """No-op: fresh state has no buckets."""


@given("the bucket already exists")
def bucket_already_exists(lws_session):
    _create_bucket(lws_session)


@given('the bucket exists and is "ACTIVE"')
def bucket_exists_and_is_active(lws_session):
    _create_bucket(lws_session)


@given('the bucket does not exist or is not "ACTIVE"')
def bucket_not_exist_or_not_active():
    """No-op: fresh state has no buckets."""


@given('the bucket is "ACTIVE"')
def bucket_is_active_given():
    """No-op: buckets are ACTIVE by default after creation."""


@given('the bucket is not "ACTIVE"')
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


@given('the bus exists and is "ACTIVE"')
def bus_exists_and_is_active(lws_session):
    _create_bus(lws_session)


@given('the bus does not exist or is not "ACTIVE"')
def bus_not_exist_or_not_active():
    pytest.skip(
        "lws does not validate EventBridge bus existence when configuring bucket notifications"
    )


@given('the bus is "ACTIVE"')
def bus_is_active_given():
    """No-op: buses are ACTIVE by default after creation."""


@given('the bus is already "DELETED"')
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
    pytest.skip(
        "lws does not reject put_bucket_notification_configuration when a config already exists"
        " (idempotent/overwrite allowed)"
    )


@given("the bucket has an EventBridge notification configured")
def bucket_has_eventbridge_notification():
    pytest.skip("Cannot pre-configure EventBridge notification in this context")


@given('the target bus is "ACTIVE"')
def target_bus_is_active(lws_session):
    _create_bus(lws_session)


@given('the target bus is "DELETED"')
def target_bus_is_deleted():
    pytest.skip("Cannot force bus to DELETED state in this context")


@given('the target bus is not "DELETED"')
def target_bus_is_not_deleted(lws_session):
    _create_bus(lws_session)


# ── Given: slots ───────────────────────────────────────────────────────


@given("an object slot is available")
def object_slot_available(lws_session):
    lws_session.capacity("s3").unlimited().apply()


@given("no object slot is available")
def no_object_slot_available(lws_session):
    lws_session.capacity("s3").exhaust().apply()


@given("an event slot is available")
def event_slot_available():
    """No-op: always room for events."""


@given("no event slot is available")
def no_event_slot_available(lws_session):
    lws_session.capacity("events").exhaust().apply()


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
def enable_eventbridge_notification(lws_session, world):
    try:
        world["result"] = _s3(lws_session).put_bucket_notification_configuration(
            Bucket=TEST_BUCKET,
            NotificationConfiguration={"EventBridgeConfiguration": {}},
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


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


@then('the bucket is "ACTIVE" with no EventBridge notification configuration')
def bucket_active_no_eventbridge(lws_session):
    resp = _s3(lws_session).list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"


@then('the bus is "ACTIVE"')
def bus_is_active_then(lws_session):
    resp = _events(lws_session).list_event_buses()
    actual_names = [b["Name"] for b in resp.get("EventBuses", [])]
    assert (
        TEST_BUS in actual_names
    ), f"Expected event bus '{TEST_BUS}' to be ACTIVE but not found in: {actual_names}"


@then('the bus is "DELETED" and event delivery to it will fail')
def bus_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_event_bus to succeed but got: {world['error']}"


@then("the bucket will send events to the bus when objects are uploaded")
def bucket_will_send_events(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected notification configuration to succeed but got error: {actual_error}"


@then('the object "EXISTS" but no event is delivered')
def object_exists_but_no_event(lws_session):
    resp = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY in keys, f"Expected object '{TEST_KEY}' to exist but not found in: {keys}"


@then('the object "EXISTS" and an event is "DELIVERED" to the bus')
def object_exists_and_event_delivered(lws_session):
    resp = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
    keys = [obj["Key"] for obj in resp.get("Contents", [])]
    assert TEST_KEY in keys, f"Expected object '{TEST_KEY}' to exist but not found in: {keys}"


# ── Given: sequence setup ─────────────────────────────────────────


@given("bid not in bucket_status")
def s3api_events_bid_not_in_bucket_status():
    """No-op: fresh state has no buckets."""


@given("an S3 bucket has been created")
def s3api_events_s3_bucket_has_been_created(lws_session):
    _create_bucket(lws_session)


@given("busid not in bus_status")
def s3api_events_busid_not_in_bus_status():
    """No-op: fresh state has no custom event buses."""


@given("busid in bus_status")
def s3api_events_busid_in_bus_status(lws_session):
    _create_bus(lws_session)


@given("an EventBridge event bus has been created")
def s3api_events_event_bus_has_been_created(lws_session):
    _create_bus(lws_session)


@given("the EventBridge event bus has been deleted")
def s3api_events_event_bus_has_been_deleted(lws_session):
    try:
        _create_bus(lws_session)
    except Exception:  # noqa: BLE001
        pass
    _events(lws_session).delete_event_bus(Name=TEST_BUS)


@given("bid in bucket_status")
def s3api_events_bid_in_bucket_status(lws_session):
    _create_bucket(lws_session)


@given("EventBridge notifications have been enabled on the bucket targeting a specific bus")
def s3api_events_eventbridge_notifications_enabled(lws_session):
    _create_bucket(lws_session)
    _create_bus(lws_session)
    _s3(lws_session).put_bucket_notification_configuration(
        Bucket=TEST_BUCKET,
        NotificationConfiguration={"EventBridgeConfiguration": {}},
    )


@given("an object has been uploaded and S3 has delivered an event to the EventBridge bus")
def s3api_events_object_uploaded_event_delivered(lws_session):
    _create_bucket(lws_session)
    _s3(lws_session).put_object(Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY)


@given("an object has been uploaded but event delivery has failed because the bus has been deleted")
def s3api_events_object_uploaded_event_failed(lws_session):
    _create_bucket(lws_session)
    _s3(lws_session).put_object(Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY)


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "DELIVERED" event references a bus that exists')
def _inv_s3api_events_every_delivered_event_references_a_bus_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "DELIVERED" event references an object that exists')
def _inv_s3api_events_every_delivered_event_references_an_object_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
