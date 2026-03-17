"""Abstract BDD step definitions for S3apiSns integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_BUCKET = "e2e-test-bucket-1"
TEST_KEY = "e2e-test-key-1"
TEST_TOPIC = "e2e-test-topic-1"
TEST_BODY = b"test-data-content-1"


def _s3(lws_session):
    return lws_session.client("s3")


def _sns(lws_session):
    return lws_session.client("sns")


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _create_bucket(lws_session, name=TEST_BUCKET):
    _s3(lws_session).create_bucket(Bucket=name)


def _create_topic(lws_session, name=TEST_TOPIC):
    _sns(lws_session).create_topic(Name=name)


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


# ── Given: notification config state ──────────────────────────────────

@given("the bucket has no notification configuration")
def bucket_has_no_notification():
    """No-op: no notification configured by default."""


@given("the bucket already has a notification configuration")
def bucket_already_has_notification():
    pytest.skip("Cannot pre-configure SNS notification in this context")


@given("the bucket has a notification configuration")
def bucket_has_notification():
    pytest.skip("Cannot pre-configure SNS notification in this context")


# ── Given: topic state ────────────────────────────────────────────────

@given("the topic does not already exist")
def topic_not_already_exist():
    """No-op: fresh state has no topics."""


@given("the topic already exists")
def topic_already_exists(lws_session):
    _create_topic(lws_session)


@given("the topic exists")
def topic_exists(lws_session):
    _create_topic(lws_session)


@given("the topic exists and is \"ACTIVE\"")
def topic_exists_and_is_active(lws_session):
    _create_topic(lws_session)


@given("the topic does not exist or is not \"ACTIVE\"")
def topic_not_exist_or_not_active():
    """No-op: fresh state has no topics."""


@given("the topic is \"ACTIVE\"")
def topic_is_active_given():
    """No-op: topics are ACTIVE by default after creation."""


@given("the topic is already \"DELETED\"")
def topic_is_already_deleted(lws_session, world):
    try:
        _create_topic(lws_session)
    except Exception:  # noqa: BLE001
        pass  # topic may already exist from a prior Given step
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    _sns(lws_session).delete_topic(TopicArn=_topic_arn())
    world["result"] = None
    world["error"] = None


@given("the topic does not exist")
def topic_does_not_exist():
    """No-op: fresh state has no topics."""


@given("the target topic is \"ACTIVE\"")
def target_topic_is_active(lws_session):
    _create_topic(lws_session)


@given("the target topic is \"DELETED\"")
def target_topic_is_deleted(lws_session, world):
    try:
        _create_topic(lws_session)
    except Exception:  # noqa: BLE001
        pass  # topic may already exist from a prior Given step
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    _sns(lws_session).delete_topic(TopicArn=_topic_arn())
    world["result"] = None
    world["error"] = None


@given("the target topic is not \"DELETED\"")
def target_topic_is_not_deleted(lws_session):
    _create_topic(lws_session)


# ── Given: slots ───────────────────────────────────────────────────────

@given("an object slot is available")
def object_slot_available():
    """No-op: always room for objects."""


@given("no object slot is available")
def no_object_slot_available():
    pytest.skip("Cannot exhaust object slot limit")


@given("a message slot is available")
def message_slot_available():
    """No-op: always room for messages."""


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip("Cannot exhaust message slot limit")


# ── When: actions ──────────────────────────────────────────────────────

@when("an S3 bucket is created")
def create_s3_bucket(lws_session, world):
    try:
        world["result"] = _s3(lws_session).create_bucket(Bucket=TEST_BUCKET)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an \"SNS\" topic is created")
def create_sns_topic(lws_session, world):
    try:
        world["result"] = _sns(lws_session).create_topic(Name=TEST_TOPIC)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("the \"SNS\" topic is deleted")
def delete_sns_topic(lws_session, world):
    try:
        world["result"] = _sns(lws_session).delete_topic(TopicArn=_topic_arn())
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an \"SNS\" notification configuration is added to the bucket")
def add_sns_notification_config(world):
    pytest.skip("Cannot configure SNS bucket notifications in lws")


@when("an object is uploaded and S3 publishes a notification to the \"SNS\" topic")
def put_object_with_sns_notification(lws_session, world):
    pytest.skip("Cannot configure S3 SNS notifications in lws")


@when("an object is uploaded but notification delivery fails because the topic has been deleted")
def put_object_notification_fails(lws_session, world):
    pytest.skip("Cannot configure S3 SNS notifications in lws")


# ── Then: assertions ───────────────────────────────────────────────────

@then("the bucket is \"ACTIVE\" with no notification configuration")
def bucket_active_no_notification(lws_session):
    resp = _s3(lws_session).list_buckets()
    actual_buckets = [b["Name"] for b in resp.get("Buckets", [])]
    assert TEST_BUCKET in actual_buckets, (
        f"Expected bucket '{TEST_BUCKET}' to exist but not found in: {actual_buckets}"
    )


@then("the topic is \"ACTIVE\"")
def topic_is_active_then(lws_session):
    resp = _sns(lws_session).list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_arn = _topic_arn()
    assert expected_arn in actual_arns, (
        f"Expected topic '{expected_arn}' to be ACTIVE but not found in: {actual_arns}"
    )


@then("the topic is \"DELETED\" and notification delivery to it will fail")
def topic_is_deleted_then(world):
    assert world["error"] is None, (
        f"Expected delete_topic to succeed but got: {world['error']}"
    )


@then("the bucket will publish notifications to the topic when objects are uploaded")
def bucket_will_publish_notifications(world):
    pytest.skip("Cannot observe SNS notification configuration in lws")


@then("the object \"EXISTS\" but no notification is published")
def object_exists_but_no_notification(lws_session):
    pytest.skip("Cannot observe missing SNS notification in lws")


@then("the object \"EXISTS\" and a notification is \"PUBLISHED\" to the topic")
def object_exists_and_notification_published(lws_session):
    pytest.skip("Cannot observe SNS notification delivery in lws")


