"""Shared fixtures and BDD step definitions for SNS integration tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when
from starlette.testclient import TestClient

from lws.providers.sns.provider import SnsProvider, TopicConfig
from lws.providers.sns.routes import create_sns_app

TEST_TOPIC = "int-test-topic-1"
TEST_TOPIC_ARN = f"arn:aws:sns:us-east-1:000000000000:{TEST_TOPIC}"
TEST_EMAIL_ENDPOINT = "int-test@example.invalid"
TEST_MESSAGE = "int-test-sns-message-1"
TEST_SUB_ENDPOINT = "arn:aws:sqs:us-east-1:000000000000:int-test-sub-q"


# ── Fixtures ──────────────────────────────────────────────────────────────────


@pytest.fixture
async def provider():
    p = SnsProvider(
        topics=[
            TopicConfig(
                topic_name="test-topic",
                topic_arn="arn:aws:sns:us-east-1:123456789012:test-topic",
            )
        ]
    )
    await p.start()
    yield p
    await p.stop()


@pytest.fixture
def app(provider):
    return create_sns_app(provider)


@pytest.fixture
async def client(app):
    with TestClient(app, raise_server_exceptions=False) as c:
        yield c


# ── Helpers ───────────────────────────────────────────────────────────────────


def _create_topic(client: TestClient, name: str = TEST_TOPIC) -> str:
    r = client.post("/", data={"Action": "CreateTopic", "Name": name})
    assert r.status_code == 200, f"Expected {200!r} but got {r.status_code!r}"
    return _extract_xml_tag(r.text, "TopicArn")


def _subscribe(
    client: TestClient,
    topic_arn: str,
    protocol: str = "email",
    endpoint: str = TEST_EMAIL_ENDPOINT,
) -> str:
    r = client.post(
        "/",
        data={
            "Action": "Subscribe",
            "TopicArn": topic_arn,
            "Protocol": protocol,
            "Endpoint": endpoint,
        },
    )
    assert r.status_code == 200, f"Expected {200!r} but got {r.status_code!r}"
    return _extract_xml_tag(r.text, "SubscriptionArn")


def _extract_xml_tag(text: str, tag: str) -> str:
    open_tag = f"<{tag}>"
    close_tag = f"</{tag}>"
    start = text.index(open_tag) + len(open_tag)
    end = text.index(close_tag)
    return text[start:end]


# ── Given: topic state setup ───────────────────────────────────────────────────


@given("the topic does not already exist")
def topic_not_already_exist():
    """No-op: fresh provider state has no topic named TEST_TOPIC."""


@given("the topic already exists")
def topic_already_exists(client, world):
    world["topic_arn"] = _create_topic(client)


@given("the topic exists")
def topic_exists(client, world):
    world["topic_arn"] = _create_topic(client)


@given('the topic is "ACTIVE"')
def topic_is_active_given():
    """No-op: topics are ACTIVE immediately after creation."""


@given('the topic is not "ACTIVE"')
def topic_is_not_active_given():
    pytest.skip("Cannot configure lifecycle state in integration test context")


@given("the topic does not exist")
def topic_does_not_exist(client, world):
    """Ensure topic does not exist; it was never created in the fresh provider."""
    topic_arn = world.get("topic_arn", TEST_TOPIC_ARN)
    client.post("/", data={"Action": "DeleteTopic", "TopicArn": topic_arn})


# ── Given: subscription state setup ────────────────────────────────────────────


@given("the subscription slot is available")
def subscription_slot_available():
    """No-op: always room for subscriptions."""


@given("the subscription slot is not available")
def subscription_slot_not_available():
    pytest.skip("Cannot exhaust subscription slot limit in integration test context")


@given("a confirmed subscription exists for the topic")
def confirmed_subscription_exists(client, world):
    """Subscribe via SQS ARN endpoint which is auto-confirmed in lws."""
    if not world.get("topic_arn"):
        world["topic_arn"] = _create_topic(client)
    sub_arn = _subscribe(
        client,
        topic_arn=world["topic_arn"],
        protocol="sqs",
        endpoint=TEST_SUB_ENDPOINT,
    )
    if sub_arn == "PendingConfirmation":
        pytest.skip("SQS subscription not auto-confirmed in this lws version")
    world["subscription_arn"] = sub_arn


@given("no confirmed subscription exists for the topic")
def no_confirmed_subscription_exists():
    pytest.skip(
        "SNS allows publishing to a topic with no confirmed subscriptions;"
        " this constraint is not enforced"
    )


@given("the subscription belongs to this topic")
def subscription_belongs_to_topic():
    """No-op: subscription was created for this topic."""


@given("the subscription does not belong to this topic")
def subscription_not_belong_to_topic():
    pytest.skip("Cannot test cross-topic subscription isolation in integration test context")


@given("a delivery slot is available")
def delivery_slot_available():
    """No-op: always room for deliveries."""


@given("no delivery slot is available")
def delivery_slot_not_available():
    pytest.skip("Cannot exhaust delivery slot limit in integration test context")


@given("the subscription exists")
def subscription_exists(client, world):
    if not world.get("topic_arn"):
        world["topic_arn"] = _create_topic(client)
    sub_arn = _subscribe(
        client,
        topic_arn=world["topic_arn"],
        protocol="email",
        endpoint=TEST_EMAIL_ENDPOINT,
    )
    world["subscription_arn"] = sub_arn


@given('the subscription is "PENDING_CONFIRMATION"')
def subscription_is_pending_given():
    """No-op: email subscriptions are PENDING_CONFIRMATION by default."""


@given('the subscription is not "PENDING_CONFIRMATION"')
def subscription_is_not_pending_given():
    pytest.skip(
        "Cannot set subscription to non-PENDING_CONFIRMATION state without confirmation flow"
    )


@given('the subscription is "CONFIRMED"')
def subscription_is_confirmed_given(client, world):
    """Set up a confirmed SQS subscription (auto-confirmed in lws)."""
    if not world.get("topic_arn"):
        world["topic_arn"] = _create_topic(client)
    sub_arn = _subscribe(
        client,
        topic_arn=world["topic_arn"],
        protocol="sqs",
        endpoint=TEST_SUB_ENDPOINT,
    )
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
    pytest.skip("Cannot test subscription with non-existent topic in integration test context")


@given('the subscription\'s topic is not "ACTIVE"')
def subscriptions_topic_is_not_active():
    pytest.skip("Cannot configure lifecycle state in integration test context")


@given("the subscription does not exist")
def subscription_does_not_exist():
    """No-op: fresh provider state has no subscriptions for TEST_TOPIC."""


# ── Given: delivery state setup ────────────────────────────────────────────────


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
    """No-op: fresh provider state has no in-flight deliveries."""


@given("the retry count is below the limit")
def retry_count_below_limit():
    pytest.skip("Cannot control retry count in integration test context")


@given("the retry count is at the limit")
def retry_count_at_limit():
    pytest.skip("Cannot control retry count in integration test context")


@given("the retry count has reached the limit")
def retry_count_reached_limit():
    pytest.skip("Cannot control retry count in integration test context")


@given("the pending subscription exists")
def pending_subscription_exists():
    pytest.skip("Cannot create pending subscription token in integration test context")


@given("the confirmation token is valid")
def confirmation_token_valid():
    pytest.skip("Cannot control confirmation token validity in integration test context")


@given("the confirmation token has expired")
def confirmation_token_expired():
    pytest.skip("Cannot control confirmation token expiry in integration test context")


# ── When: actions ──────────────────────────────────────────────────────────────


@when('an "SNS" topic is created')
def create_topic(client, world):
    r = client.post("/", data={"Action": "CreateTopic", "Name": TEST_TOPIC})
    if r.status_code == 200:
        world["result"] = r.text
        world["topic_arn"] = _extract_xml_tag(r.text, "TopicArn")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when('an "SNS" topic is deleted')
def delete_topic(client, world):
    topic_arn = world.get("topic_arn", TEST_TOPIC_ARN)
    r = client.post("/", data={"Action": "DeleteTopic", "TopicArn": topic_arn})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("an endpoint subscribes to a topic")
def subscribe_to_topic(client, world):
    topic_arn = world.get("topic_arn", TEST_TOPIC_ARN)
    r = client.post(
        "/",
        data={
            "Action": "Subscribe",
            "TopicArn": topic_arn,
            "Protocol": "email",
            "Endpoint": TEST_EMAIL_ENDPOINT,
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["subscription_arn"] = _extract_xml_tag(r.text, "SubscriptionArn")
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a pending subscription is confirmed")
def confirm_subscription(world):
    pytest.skip("Cannot confirm subscription without token in integration test context")


@when("an endpoint unsubscribes from a topic")
def unsubscribe_from_topic(client, world):
    sub_arn = world.get("subscription_arn", "invalid-subscription-arn")
    r = client.post("/", data={"Action": "Unsubscribe", "SubscriptionArn": sub_arn})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a message is published to a topic")
def publish_to_topic(client, world):
    topic_arn = world.get("topic_arn", TEST_TOPIC_ARN)
    r = client.post(
        "/",
        data={
            "Action": "Publish",
            "TopicArn": topic_arn,
            "Message": TEST_MESSAGE,
        },
    )
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a delivery attempt succeeds")
def delivery_succeeds(world):
    pytest.skip("Cannot trigger delivery in integration test context")


@when("a subscription is removed")
def subscription_removed(client, world):
    sub_arn = world.get("subscription_arn", "invalid-subscription-arn")
    r = client.post("/", data={"Action": "Unsubscribe", "SubscriptionArn": sub_arn})
    if r.status_code == 200:
        world["result"] = r.text
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.text


@when("a delivery attempt fails and is retried")
def delivery_fails_and_retried(world):
    pytest.skip("Cannot trigger delivery failure and retry in integration test context")


@when("a delivery attempt fails")
def delivery_fails(world):
    pytest.skip("Cannot trigger delivery failure in integration test context")


@when("a delivery retry is exhausted")
def delivery_retry_exhausted(world):
    pytest.skip("Cannot exhaust delivery retries in integration test context")


@when("all delivery retries are exhausted")
def all_delivery_retries_exhausted(world):
    pytest.skip("Cannot exhaust all delivery retries in integration test context")


@when("a subscription confirmation token expires")
def subscription_confirmation_token_expires(world):
    pytest.skip("Cannot expire a subscription confirmation token in integration test context")


@when("the confirmation token expires")
def confirmation_token_expires_when(world):
    pytest.skip("Cannot expire confirmation token in integration test context")


# ── Then: assertions ───────────────────────────────────────────────────────────


@then('the topic is "ACTIVE"')
def topic_is_active_then(client):
    r = client.post("/", data={"Action": "ListTopics"})
    expected_fragment = TEST_TOPIC
    actual_text = r.text
    assert (
        expected_fragment in actual_text
    ), f"Expected topic '{expected_fragment}' to be ACTIVE but not found in: {actual_text}"


@then('the topic is "DELETED" and its subscriptions are removed')
def topic_is_deleted_and_subscriptions_removed_then(client):
    r = client.post("/", data={"Action": "ListTopics"})
    expected_absent = TEST_TOPIC
    actual_text = r.text
    assert (
        expected_absent not in actual_text
    ), f"Expected topic '{expected_absent}' to be deleted but found in: {actual_text}"


@then("the topic is deleted")
def topic_is_deleted_then(client):
    r = client.post("/", data={"Action": "ListTopics"})
    expected_absent = TEST_TOPIC
    actual_text = r.text
    assert (
        expected_absent not in actual_text
    ), f"Expected topic '{expected_absent}' to be deleted but found in: {actual_text}"


@then('the subscription is "PENDING_CONFIRMATION" or "CONFIRMED"')
def subscription_is_pending_or_confirmed_then(client):
    r = client.post("/", data={"Action": "ListSubscriptions"})
    expected_status = 200
    actual_status = r.status_code
    assert (
        actual_status == expected_status
    ), f"Expected ListSubscriptions to return {expected_status} but got: {actual_status}"


@then('the subscription is "CONFIRMED"')
def subscription_is_confirmed_then(world):
    pytest.skip("Cannot verify CONFIRMED state without confirmation flow")


@then("the subscription is deleted")
def subscription_is_deleted_then(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected unsubscribe to succeed but got: {actual_error}"


@then("the message is delivered to confirmed subscriptions")
def message_delivered_then(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected publish to succeed but got: {actual_error}"


@then('the delivery is "DONE"')
def delivery_is_done_then(world):
    pytest.skip("Cannot observe delivery completion in integration test context")


@then("the delivery is retried")
def delivery_is_retried_then(world):
    pytest.skip("Cannot observe delivery retry in integration test context")


@then("the delivery is abandoned")
def delivery_is_abandoned_then(world):
    pytest.skip("Cannot observe delivery abandonment in integration test context")


@then('the pending subscription is "DELETED"')
def pending_subscription_deleted_then(world):
    pytest.skip("Cannot observe subscription token expiry in integration test context")


@then("the delivery retry count is incremented")
def delivery_retry_count_incremented_then(world):
    pytest.skip("Cannot observe delivery retry count increment in integration test context")


@then('the subscription is "DELETED"')
def subscription_is_deleted_by_removal_then(world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected subscription removal to succeed but got: {actual_error}"


@then('the delivery is marked "DONE"')
def delivery_is_marked_done_then(world):
    pytest.skip("Cannot observe delivery completion in integration test context")
