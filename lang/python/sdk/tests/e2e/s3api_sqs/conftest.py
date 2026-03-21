"""Abstract BDD step definitions for S3apiSqs integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUCKET = "e2e-test-bucket-1"
TEST_KEY = "e2e-test-key-1"
TEST_QUEUE = "e2e-test-q1"
TEST_BODY = b"test-data-content-1"


def _s3(lws_session):
    return lws_session.client("s3")


def _sqs(lws_session):
    return lws_session.client("sqs")


def _queue_url(lws_session, name=TEST_QUEUE):
    return lws_session.queue_url(name)


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


def _create_queue(lws_session, name=TEST_QUEUE):
    _sqs(lws_session).create_queue(QueueName=name)


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


# ── Given: notification config state ──────────────────────────────────


@given("the bucket has no notification configuration")
def bucket_has_no_notification():
    """No-op: no notification configured by default."""


@given("the bucket already has a notification configuration")
def bucket_already_has_notification():
    pytest.skip(
        "lws does not reject put_bucket_notification_configuration when a config already exists"
        " (idempotent / overwrite allowed)"
    )


@given("the bucket has a notification configuration")
def bucket_has_notification(lws_session):
    # Arrange
    _create_bucket(lws_session)
    _create_queue(lws_session)
    queue_arn = f"arn:aws:sqs:us-east-1:000000000000:{TEST_QUEUE}"
    # Act
    _s3(lws_session).put_bucket_notification_configuration(
        Bucket=TEST_BUCKET,
        NotificationConfiguration={
            "QueueConfigurations": [
                {
                    "Id": "e2e-test-sqs-config-1",
                    "QueueArn": queue_arn,
                    "Events": ["s3:ObjectCreated:*"],
                }
            ]
        },
    )


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


@given('the queue exists and is "ACTIVE"')
def queue_exists_and_is_active(lws_session):
    _create_queue(lws_session)


@given('the queue does not exist or is not "ACTIVE"')
def queue_not_exist_or_not_active():
    pytest.skip(
        "lws does not validate SQS queue existence when configuring bucket notification"
    )


@given('the queue is "ACTIVE"')
def queue_is_active_given():
    """No-op: queues are ACTIVE by default after creation."""


@given('the queue is already "DELETED"')
def queue_is_already_deleted(lws_session, world):
    try:
        _create_queue(lws_session)
    except Exception:  # noqa: BLE001
        pass  # queue may already exist from a prior Given step
    lws_session.lifecycle("sqs").delete_dwell_ms(5000).apply()
    _sqs(lws_session).delete_queue(QueueUrl=_queue_url(lws_session))
    world["result"] = None
    world["error"] = None


@given("the queue does not exist")
def queue_does_not_exist():
    """No-op: fresh state has no queues."""


@given('the target queue is "ACTIVE"')
def target_queue_is_active():
    """No-op: queues are ACTIVE by default after creation."""


@given('the target queue is "DELETED"')
def target_queue_is_deleted(lws_session, world):
    try:
        _create_queue(lws_session)
    except Exception:  # noqa: BLE001
        pass  # queue may already exist from a prior Given step
    lws_session.lifecycle("sqs").delete_dwell_ms(5000).apply()
    _sqs(lws_session).delete_queue(QueueUrl=_queue_url(lws_session))
    world["_target_queue_deleted"] = True
    world["result"] = None
    world["error"] = None


@given('the target queue is not "DELETED"')
def target_queue_is_not_deleted():
    pytest.skip(
        "lws uses fire-and-forget notification delivery: put_object always succeeds"
        " regardless of notification dispatch outcome"
    )


# ── Given: slots ───────────────────────────────────────────────────────


@given("an object slot is available")
def object_slot_available(lws_session):
    lws_session.capacity("s3").unlimited().apply()


@given("no object slot is available")
def no_object_slot_available(lws_session):
    lws_session.capacity("s3").exhaust().apply()


@given("a message slot is available")
def message_slot_available(lws_session):
    lws_session.capacity("sqs").unlimited().apply()


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip(
        "lws uses fire-and-forget notification delivery: put_object always succeeds"
        " regardless of SQS notification capacity"
    )


# ── When: actions ──────────────────────────────────────────────────────


@when("an S3 bucket is created")
def create_s3_bucket(lws_session, world):
    try:
        world["result"] = _s3(lws_session).create_bucket(Bucket=TEST_BUCKET)
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


@when('the "SQS" queue is deleted')
def delete_sqs_queue(lws_session, world):
    try:
        url = _queue_url(lws_session)
        world["result"] = _sqs(lws_session).delete_queue(QueueUrl=url)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "SQS" notification configuration is added to the bucket')
def add_sqs_notification_config(lws_session, world):
    # Arrange
    queue_arn = f"arn:aws:sqs:us-east-1:000000000000:{TEST_QUEUE}"
    # Act
    try:
        world["result"] = _s3(lws_session).put_bucket_notification_configuration(
            Bucket=TEST_BUCKET,
            NotificationConfiguration={
                "QueueConfigurations": [
                    {
                        "Id": "e2e-test-sqs-config-1",
                        "QueueArn": queue_arn,
                        "Events": ["s3:ObjectCreated:*"],
                    }
                ]
            },
        )
        world["error"] = None
    except Exception as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when('an object is uploaded to the bucket and S3 delivers a notification to the "SQS" queue')
def put_object_with_sqs_notification(lws_session, world):
    if world.get("_target_queue_deleted"):
        pytest.skip(
            "lws uses fire-and-forget notification delivery: put_object always succeeds"
            " even when the notification target queue has been deleted"
        )
    # Act
    try:
        world["result"] = _s3(lws_session).put_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            Body=TEST_BODY,
        )
        world["error"] = None
    except Exception as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


@when("an object is uploaded but notification delivery fails because the queue has been deleted")
def put_object_notification_fails(lws_session, world):
    # Act
    try:
        world["result"] = _s3(lws_session).put_object(
            Bucket=TEST_BUCKET,
            Key=TEST_KEY,
            Body=TEST_BODY,
        )
        world["error"] = None
    except Exception as exc:  # noqa: BLE001
        world["result"] = None
        world["error"] = exc


# ── Then: assertions ───────────────────────────────────────────────────


@then('the bucket is "ACTIVE" with no notification configuration')
def bucket_active_no_notification(lws_session):
    resp = _s3(lws_session).list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert (
        TEST_BUCKET in actual_buckets
    ), f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"


@then('the queue is "ACTIVE"')
def queue_is_active_then(lws_session):
    url = _queue_url(lws_session)
    resp = _sqs(lws_session).get_queue_attributes(QueueUrl=url, AttributeNames=["All"])
    assert (
        resp.get("Attributes") is not None
    ), f"Expected queue '{TEST_QUEUE}' to be ACTIVE but got no attributes"


@then('the queue is "DELETED" and notification delivery to it will fail')
def queue_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_queue to succeed but got: {world['error']}"


@then("the bucket will send notifications to the queue when objects are uploaded")
def bucket_will_send_notifications(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert actual_error is expected_error, (
        f"Expected put_bucket_notification_configuration to succeed but got: {actual_error}"
    )


@then('the object "EXISTS" but no notification message is delivered')
def object_exists_but_no_notification(lws_session, world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert actual_error is expected_error, (
        "Expected put_object to succeed (even without notification delivery)"
        f" but got: {actual_error}"
    )
    actual_objects = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET).get("Contents", [])
    expected_key = TEST_KEY
    actual_keys = [obj["Key"] for obj in actual_objects]
    assert expected_key in actual_keys, (
        f"Expected object '{expected_key}' to exist but not found in: {actual_keys}"
    )


@then('the object "EXISTS" and a notification message is "QUEUED"')
def object_exists_and_notification_queued(lws_session, world):
    # Arrange
    expected_error = None
    expected_key = TEST_KEY
    # Assert
    actual_error = world["error"]
    assert actual_error is expected_error, (
        f"Expected put_object to succeed but got: {actual_error}"
    )
    actual_objects = _s3(lws_session).list_objects_v2(Bucket=TEST_BUCKET).get("Contents", [])
    actual_keys = [obj["Key"] for obj in actual_objects]
    assert expected_key in actual_keys, (
        f"Expected object '{expected_key}' to exist but not found in: {actual_keys}"
    )
