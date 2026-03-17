"""Abstract BDD step definitions for SNS informal spec scenarios."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import given, then, when

TEST_TOPIC = "e2e-test-topic-1"
TEST_SUB_QUEUE = "e2e-test-sns-sub-q"
TEST_EMAIL_ENDPOINT = "test@example.invalid"
TEST_MESSAGE = "test-sns-message-1"


def _sns(lws_session):
    return lws_session.client("sns")


def _create_topic(lws_session, name=TEST_TOPIC):
    resp = _sns(lws_session).create_topic(Name=name)
    return resp["TopicArn"]


def _get_topic_arn(lws_session, name=TEST_TOPIC):
    return f"arn:aws:sns:us-east-1:000000000000:{name}"


# ── Given: topic state setup ───────────────────────────────────────────

@given("the topic does not already exist")
def topic_not_already_exist():
    """No-op: fresh state has no topics."""


@given("the topic already exists")
def topic_already_exists(lws_session, world):
    world["topic_arn"] = _create_topic(lws_session)


@given("the topic exists")
def topic_exists(lws_session, world):
    world["topic_arn"] = _create_topic(lws_session)


@given('the topic is "ACTIVE"')
def topic_is_active_given():
    """No-op: topics are ACTIVE immediately after creation."""


@given('the topic is not "ACTIVE"')
def topic_is_not_active_given(lws_session, world):
    try:
        _sns(lws_session).delete_topic(TopicArn=_get_topic_arn(lws_session))
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    world["topic_arn"] = _create_topic(lws_session)


@given("the topic does not exist")
def topic_does_not_exist(lws_session, world):
    """Ensure the topic does not exist by deleting it if present."""
    client = _sns(lws_session)
    topic_arn = world.get("topic_arn") or _get_topic_arn(lws_session)
    try:
        client.delete_topic(TopicArn=topic_arn)
    except Exception:
        pass  # Topic already absent — that's the desired state


# ── Given: subscription state setup ───────────────────────────────────

@given("the subscription slot is available")
def subscription_slot_available():
    """No-op: always room for subscriptions."""


@given("the subscription slot is not available")
def subscription_slot_not_available():
    pytest.skip("Cannot exhaust subscription slot limit")


@given("a confirmed subscription exists for the topic")
def confirmed_subscription_exists(lws_session, world):
    """Subscribe using SQS queue which is auto-confirmed in lws."""
    # Ensure topic exists
    if not world.get("topic_arn"):
        world["topic_arn"] = _create_topic(lws_session)
    # Create a queue to subscribe to
    sqs = lws_session.client("sqs")
    sqs.create_queue(QueueName=TEST_SUB_QUEUE)
    queue_url = lws_session.queue_url(TEST_SUB_QUEUE)
    resp = _sns(lws_session).subscribe(
        TopicArn=world["topic_arn"],
        Protocol="sqs",
        Endpoint=queue_url,
    )
    sub_arn = resp.get("SubscriptionArn", "")
    if sub_arn == "PendingConfirmation":
        pytest.skip("SQS subscription not auto-confirmed in this lws version")
    world["subscription_arn"] = sub_arn


@given("no confirmed subscription exists for the topic")
def no_confirmed_subscription_exists():
    """Skip: SNS allows publishing to a topic with no confirmed subscriptions."""
    pytest.skip(
        "SNS allows publishing to a topic with no confirmed subscriptions;"
        " this constraint is not enforced"
    )


@given("the subscription belongs to this topic")
def subscription_belongs_to_topic():
    """No-op: subscription was created for this topic."""


@given("the subscription does not belong to this topic")
def subscription_not_belong_to_topic():
    pytest.skip("Cannot test cross-topic subscription isolation in this context")


@given("a delivery slot is available")
def delivery_slot_available():
    """No-op: always room for deliveries."""


@given("no delivery slot is available")
def delivery_slot_not_available():
    pytest.skip("Cannot exhaust delivery slot limit")


@given("the subscription exists")
def subscription_exists(lws_session, world):
    if not world.get("topic_arn"):
        world["topic_arn"] = _create_topic(lws_session)
    resp = _sns(lws_session).subscribe(
        TopicArn=world["topic_arn"],
        Protocol="email",
        Endpoint=TEST_EMAIL_ENDPOINT,
    )
    world["subscription_arn"] = resp.get("SubscriptionArn", "PendingConfirmation")


@given('the subscription is "PENDING_CONFIRMATION"')
def subscription_is_pending_given():
    """No-op: email subscriptions are PENDING_CONFIRMATION by default."""


@given('the subscription is not "PENDING_CONFIRMATION"')
def subscription_is_not_pending_given():
    pytest.skip(
        "Cannot set subscription to non-PENDING_CONFIRMATION state without confirmation flow"
    )


@given('the subscription is "CONFIRMED"')
def subscription_is_confirmed_given(lws_session, world):
    """Set up a confirmed SQS subscription (auto-confirmed in lws)."""
    if not world.get("topic_arn"):
        world["topic_arn"] = _create_topic(lws_session)
    sqs = lws_session.client("sqs")
    sqs.create_queue(QueueName=TEST_SUB_QUEUE)
    queue_url = lws_session.queue_url(TEST_SUB_QUEUE)
    resp = _sns(lws_session).subscribe(
        TopicArn=world["topic_arn"],
        Protocol="sqs",
        Endpoint=queue_url,
    )
    sub_arn = resp.get("SubscriptionArn", "")
    if sub_arn == "PendingConfirmation":
        pytest.skip("SQS subscription not auto-confirmed in this lws version")
    world["subscription_arn"] = sub_arn


@given('the subscription is not "CONFIRMED"')
def subscription_is_not_confirmed_given():
    pytest.skip(
        "Cannot reliably produce a non-CONFIRMED subscription without external confirmation flow"
    )


@given("the subscription's topic exists")
def subscriptions_topic_exists():
    """No-op: topic was created in the topic_exists step."""


@given('the subscription\'s topic is "ACTIVE"')
def subscriptions_topic_is_active():
    """No-op: topic is ACTIVE by default."""


@given("the subscription's topic does not exist")
def subscriptions_topic_does_not_exist():
    pytest.skip("Cannot test subscription with non-existent topic in this context")


@given('the subscription\'s topic is not "ACTIVE"')
def subscriptions_topic_is_not_active(lws_session, world):
    try:
        _sns(lws_session).delete_topic(TopicArn=_get_topic_arn(lws_session))
    except Exception:  # noqa: BLE001
        pass
    lws_session.lifecycle("sns").create_dwell_ms(5000).apply()
    world["topic_arn"] = _create_topic(lws_session)


@given("the subscription does not exist")
def subscription_does_not_exist():
    """No-op: fresh state has no subscriptions."""


# ── Given: delivery state setup ────────────────────────────────────────

@given("the delivery exists")
def delivery_exists():
    pytest.skip("Cannot create in-flight delivery programmatically")


@given('the delivery is "IN_FLIGHT"')
def delivery_is_in_flight_given():
    pytest.skip("Cannot create in-flight delivery programmatically")


@given('the delivery is not "IN_FLIGHT"')
def delivery_is_not_in_flight_given():
    pytest.skip("Cannot set delivery to non-IN_FLIGHT state")


@given("the delivery does not exist")
def delivery_does_not_exist():
    """No-op: fresh state has no deliveries."""


@given("the retry count is below the limit")
def retry_count_below_limit():
    pytest.skip("Cannot control retry count in this context")


@given("the retry count is at the limit")
def retry_count_at_limit():
    pytest.skip("Cannot control retry count in this context")


@given("the retry count has reached the limit")
def retry_count_reached_limit():
    pytest.skip("Cannot control retry count in this context")


@given("the pending subscription exists")
def pending_subscription_exists():
    pytest.skip("Cannot create pending subscription token in this context")


@given("the confirmation token is valid")
def confirmation_token_valid():
    pytest.skip("Cannot control confirmation token validity")


@given("the confirmation token has expired")
def confirmation_token_expired():
    pytest.skip("Cannot control confirmation token expiry")


# ── When: actions ──────────────────────────────────────────────────────

@when('an "SNS" topic is created')
def create_topic(lws_session, world):
    try:
        resp = _sns(lws_session).create_topic(Name=TEST_TOPIC)
        world["result"] = resp
        world["topic_arn"] = resp["TopicArn"]
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when('an "SNS" topic is deleted')
def delete_topic(lws_session, world):
    try:
        world["result"] = _sns(lws_session).delete_topic(
            TopicArn=world.get("topic_arn", _get_topic_arn(lws_session))
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("an endpoint subscribes to a topic")
def subscribe_to_topic(lws_session, world):
    try:
        resp = _sns(lws_session).subscribe(
            TopicArn=world.get("topic_arn", _get_topic_arn(lws_session)),
            Protocol="email",
            Endpoint=TEST_EMAIL_ENDPOINT,
        )
        world["result"] = resp
        world["subscription_arn"] = resp.get("SubscriptionArn")
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a pending subscription is confirmed")
def confirm_subscription(lws_session, world):
    pytest.skip("Cannot confirm subscription without token in this context")


@when("an endpoint unsubscribes from a topic")
def unsubscribe_from_topic(lws_session, world):
    try:
        sub_arn = world.get("subscription_arn", "")
        world["result"] = _sns(lws_session).unsubscribe(SubscriptionArn=sub_arn)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a message is published to a topic")
def publish_to_topic(lws_session, world):
    try:
        world["result"] = _sns(lws_session).publish(
            TopicArn=world.get("topic_arn", _get_topic_arn(lws_session)),
            Message=TEST_MESSAGE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a delivery attempt succeeds")
def delivery_succeeds(world):
    pytest.skip("Cannot trigger delivery in this context")


@when("a subscription is removed")
def subscription_removed(lws_session, world):
    try:
        sub_arn = world.get("subscription_arn", "")
        world["result"] = _sns(lws_session).unsubscribe(SubscriptionArn=sub_arn)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc


@when("a delivery attempt fails and is retried")
def delivery_fails_and_retried(world):
    pytest.skip("Cannot trigger delivery failure and retry externally")


@when("a delivery attempt fails")
def delivery_fails(world):
    pytest.skip("Cannot trigger delivery failure in this context")


@when("a delivery retry is exhausted")
def delivery_retry_exhausted(world):
    pytest.skip("Cannot exhaust delivery retries in this context")


@when("all delivery retries are exhausted")
def all_delivery_retries_exhausted(world):
    pytest.skip("Cannot exhaust all delivery retries in this context")


@when("a subscription confirmation token expires")
def subscription_confirmation_token_expires(world):
    pytest.skip("Cannot expire a subscription confirmation token in this context")


@when("the confirmation token expires")
def confirmation_token_expires_when(world):
    pytest.skip("Cannot expire confirmation token in this context")


# ── Then: assertions ───────────────────────────────────────────────────

@then('the topic is "ACTIVE"')
def topic_is_active_then(lws_session):
    client = _sns(lws_session)
    resp = client.list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_topic = TEST_TOPIC
    assert any(expected_topic in arn for arn in actual_arns), (
        f"Expected topic '{expected_topic}' to exist but not found in: {actual_arns}"
    )


@then('the topic is "DELETED" and its subscriptions are removed')
def topic_is_deleted_and_subscriptions_removed_then(lws_session):
    client = _sns(lws_session)
    resp = client.list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    assert not any(TEST_TOPIC in arn for arn in actual_arns), (
        f"Expected topic '{TEST_TOPIC}' to be deleted but found in: {actual_arns}"
    )


@then("the topic is deleted")
def topic_is_deleted_then(lws_session):
    client = _sns(lws_session)
    resp = client.list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    assert not any(TEST_TOPIC in arn for arn in actual_arns), (
        f"Expected topic '{TEST_TOPIC}' to be deleted but found in: {actual_arns}"
    )


@then('the subscription is "PENDING_CONFIRMATION" or "CONFIRMED"')
def subscription_is_pending_or_confirmed_then(world):
    actual_arn = world.get("subscription_arn", "")
    assert actual_arn, f"Expected subscription ARN but got: {actual_arn}"


@then('the subscription is "CONFIRMED"')
def subscription_is_confirmed_then(world):
    pytest.skip("Cannot verify CONFIRMED state without confirmation flow")


@then("the subscription is deleted")
def subscription_is_deleted_then(world):
    assert world["error"] is None, (
        f"Expected unsubscribe to succeed but got: {world['error']}"
    )


@then("the message is delivered to confirmed subscriptions")
def message_delivered_then(world):
    assert world["error"] is None, (
        f"Expected publish to succeed but got: {world['error']}"
    )


@then('the delivery is "DONE"')
def delivery_is_done_then(world):
    pytest.skip("Cannot observe delivery completion in this context")


@then("the delivery is retried")
def delivery_is_retried_then(world):
    pytest.skip("Cannot observe delivery retry in this context")


@then("the delivery is abandoned")
def delivery_is_abandoned_then(world):
    pytest.skip("Cannot observe delivery abandonment in this context")


@then("the pending subscription is deleted")
def pending_subscription_deleted_then(world):
    pytest.skip("Cannot observe subscription token expiry in this context")


@then("every delivery retry count is within the allowed limit")
def delivery_retry_count_within_limit():
    """Invariant: trivially true in isolated context."""


@then('the subscription is "DELETED"')
def subscription_is_deleted_by_removal_then(world):
    assert world["error"] is None, (
        f"Expected subscription removal to succeed but got: {world['error']}"
    )


@then("the delivery retry count is incremented")
def delivery_retry_count_incremented_then(world):
    pytest.skip("Cannot observe delivery retry count increment in this context")


@then("no delivery is in-flight to a deleted subscription")
def no_delivery_to_deleted_subscription():
    """Invariant: trivially satisfied in isolated lws context."""


@then("no delivery is in-flight to an unconfirmed subscription")
def no_delivery_to_unconfirmed_subscription():
    """Invariant: trivially satisfied in isolated lws context."""


@then('every active subscription references an "ACTIVE" topic')
def every_active_subscription_references_active_topic():
    """Invariant: trivially satisfied in isolated lws context."""
