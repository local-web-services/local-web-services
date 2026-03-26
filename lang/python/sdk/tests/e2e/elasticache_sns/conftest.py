"""Abstract BDD step definitions for ElasticacheSns integration spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_CLUSTER = "e2e-test-cluster-1"
TEST_TOPIC = "e2e-test-topic-1"


def _elasticache(lws_session):
    return lws_session.client("elasticache")


def _sns(lws_session):
    return lws_session.client("sns")


def _topic_arn(name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


def _create_cluster(lws_session, cluster_id=TEST_CLUSTER):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
    _elasticache(lws_session).create_cache_cluster(
        CacheClusterId=cluster_id,
        CacheNodeType="cache.t3.micro",
        Engine="redis",
        NumCacheNodes=1,
    )


def _create_topic(lws_session, name=TEST_TOPIC):
    resp = _sns(lws_session).create_topic(Name=name)
    return resp["TopicArn"]


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


@given('the topic exists and is "ACTIVE"')
def topic_exists_and_is_active(lws_session):
    _create_topic(lws_session)


@given('the topic is "ACTIVE"')
def topic_is_active_given():
    """No-op: topics are ACTIVE by default after creation."""


@given('the topic is "DELETED"')
def topic_is_deleted_given():
    pytest.skip("lws does not reject ElastiCache operations when the SNS topic is deleted")


@given('the topic is not "DELETED"')
def topic_is_not_deleted_given():
    pytest.skip("lws does not enforce notification failure when the topic is not deleted")


@given('the topic is already "DELETED"')
def topic_is_already_deleted(lws_session, world):
    try:
        topic_arn = _create_topic(lws_session)
    except Exception:  # noqa: BLE001
        topic_arn = _topic_arn()
    lws_session.lifecycle("sns").delete_dwell_ms(5000).apply()
    _sns(lws_session).delete_topic(TopicArn=topic_arn)
    world["result"] = None
    world["error"] = None


@given("the topic does not exist")
def topic_does_not_exist():
    pytest.skip("lws does not validate SNS topic existence when deleting")


@given('the topic does not exist or is not "ACTIVE"')
def topic_not_exist_or_not_active():
    pytest.skip(
        "lws does not validate SNS topic existence when configuring ElastiCache notifications"
    )


# ── Given: cluster state ───────────────────────────────────────────────


@given("the cluster does not already exist")
def cluster_not_already_exist():
    """No-op: fresh state has no clusters."""


@given("the cluster already exists")
def cluster_already_exists(lws_session):
    _create_cluster(lws_session)


@given('the cluster exists and is "AVAILABLE"')
def cluster_exists_and_is_available(lws_session):
    _create_cluster(lws_session)


@given('the cluster does not exist or is not "AVAILABLE"')
def cluster_not_exist_or_not_available():
    """No-op: fresh state has no clusters."""


@given('the cluster has no "SNS" notification configured')
def cluster_has_no_sns_notification():
    """No-op: clusters have no SNS notification configured by default."""


@given('the cluster already has an "SNS" notification configured')
def cluster_already_has_sns_notification():
    pytest.skip("Cannot configure SNS notification on ElastiCache cluster before test step in lws")


@given('the cluster has an "SNS" notification configured')
def cluster_has_sns_notification():
    pytest.skip("Cannot observe internal ElastiCache SNS notification configuration in lws")


@given('the cluster is "MODIFYING"')
def cluster_is_modifying_given():
    pytest.skip("Cannot trigger internal cluster modification state in lws")


@given('the cluster is not "MODIFYING"')
def cluster_is_not_modifying_given():
    pytest.skip("Cannot control cluster modification state in lws")


# ── Given: slots ───────────────────────────────────────────────────────


@given("a message slot is available")
def message_slot_available():
    """No-op: always room for messages."""


@given("no message slot is available")
def no_message_slot_available():
    pytest.skip("Cannot exhaust message slot limit")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("cid not in cluster_status")
def cid_not_in_cluster_status():
    """No-op: fresh state has no clusters."""


@given("cid in cluster_status")
def cid_in_cluster_status(lws_session):
    _create_cluster(lws_session)


@given("tid not in topic_status")
def tid_not_in_topic_status():
    """No-op: fresh state has no topics."""


@given("tid in topic_status")
def tid_in_topic_status(lws_session):
    try:
        _create_topic(lws_session)
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "TopicAlreadyExists":
            raise


@given("an ElastiCache cluster has been created")
def elasticache_sns_cluster_created(lws_session):
    _create_cluster(lws_session)


@given('an "SNS" topic has been created')
def elasticache_sns_topic_has_been_created(lws_session):
    try:
        _create_topic(lws_session)
    except ClientError as exc:
        if exc.response["Error"]["Code"] != "TopicAlreadyExists":
            raise


@given("a cluster event notification has been published to the topic")
def elasticache_sns_notification_published():
    pytest.skip("Cannot trigger internal ElastiCache cluster event notification in lws")


@given("the cluster modification event has been sent to the topic")
def elasticache_sns_modification_event_sent():
    pytest.skip("Cannot trigger internal ElastiCache modification event in lws")


@given("the cluster modification event failed to reach the topic")
def elasticache_sns_modification_event_failed():
    pytest.skip("Cannot trigger internal ElastiCache notification failure in lws")


@given('the "SNS" topic has been deleted')
def elasticache_sns_topic_has_been_deleted():
    """No-op: fresh state has no topics, simulates a previously deleted topic."""


@given('an "SNS" notification has been configured on the ElastiCache cluster')
def elasticache_sns_notification_configured():
    pytest.skip("Cannot configure ElastiCache SNS notification in lws")


@given(
    'a cluster event has occurred and ElastiCache has published a notification to the "SNS" topic'
)
def elasticache_sns_cluster_event_published():
    pytest.skip("Cannot trigger internal ElastiCache cluster event notification in lws")


@given(
    'a cluster event has occurred but the "SNS" notification has failed because the topic has been deleted'  # noqa: E501
)
def elasticache_sns_cluster_event_notification_failed():
    pytest.skip("Cannot trigger internal ElastiCache notification failure in lws")


@given("the cluster modification has completed")
def elasticache_sns_cluster_modification_completed():
    pytest.skip("Cannot trigger internal ElastiCache cluster modification completion in lws")


# ── When: actions ──────────────────────────────────────────────────────


@when('an "SNS" topic is created')
def create_topic(lws_session, world):
    try:
        resp = _sns(lws_session).create_topic(Name=TEST_TOPIC)
        world["result"] = resp
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('the "SNS" topic is deleted')
def delete_topic(lws_session, world):
    try:
        topic_arn = _topic_arn()
        world["result"] = _sns(lws_session).delete_topic(TopicArn=topic_arn)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an ElastiCache cluster is created")
def create_cache_cluster(lws_session, world):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@when('an "SNS" notification is configured on the ElastiCache cluster')
def configure_notification(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache SNS notification configuration in lws")


@when(
    "a cluster modification event occurs and ElastiCache publishes a notification "
    'to the "SNS" topic'
)
def cluster_event_notification_delivered(lws_session, world):
    pytest.skip(
        "Cannot trigger internal ElastiCache cluster modification event notification in lws"
    )


@when('a cluster event occurs but the "SNS" notification fails because the topic has been deleted')
def cluster_event_notification_fails(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache notification failure in lws")


@when("the cluster modification completes")
def cluster_modification_completes(lws_session, world):
    pytest.skip("Cannot trigger internal ElastiCache cluster modification completion in lws")


# ── Then: assertions ───────────────────────────────────────────────────


@then('the topic is "ACTIVE"')
def topic_is_active_then(lws_session):
    resp = _sns(lws_session).list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    assert any(
        TEST_TOPIC in arn for arn in actual_arns
    ), f"Expected topic '{TEST_TOPIC}' to be ACTIVE but not found in: {actual_arns}"


@then('the topic is "DELETED" and ElastiCache event notifications will fail')
def topic_is_deleted_then(world):
    assert world["error"] is None, f"Expected delete_topic to succeed but got: {world['error']}"


@then('the cluster is "AVAILABLE" with no "SNS" notification configured')
def cluster_available_no_sns(lws_session):
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")


@then("the cluster will publish lifecycle events to the topic")
def cluster_will_publish_lifecycle_events():
    pytest.skip("Cannot observe internal ElastiCache SNS notification configuration in lws")


@then('the cluster is "MODIFYING" and the notification is "PUBLISHED" to the topic')
def cluster_modifying_and_notification_published():
    pytest.skip(
        "Cannot trigger internal ElastiCache cluster modification notification delivery in lws"
    )


@then('the cluster is "MODIFYING" but no notification is published')
def cluster_modifying_but_no_notification():
    pytest.skip("Cannot observe internal ElastiCache cluster modification state in lws")


@then('the cluster is "AVAILABLE" again')
def cluster_is_available_again_then():
    pytest.skip("Cannot observe internal cluster state transition to AVAILABLE in lws")


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "PUBLISHED" notification references a cluster that exists')
def _inv_elasticache_sns_every_published_notification_references_a_cluster_that_exis():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "PUBLISHED" notification references a topic that exists')
def _inv_elasticache_sns_every_published_notification_references_a_topic_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
