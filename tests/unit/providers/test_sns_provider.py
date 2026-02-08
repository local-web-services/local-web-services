"""Tests for the SNS provider (P1-17 through P1-21)."""

from __future__ import annotations

import asyncio
import json
from unittest.mock import AsyncMock

import httpx
import pytest

from ldk.interfaces import ICompute, InvocationResult, LambdaContext
from ldk.interfaces.queue import IQueue
from ldk.providers.sns.filter import matches_filter_policy
from ldk.providers.sns.provider import (
    SnsProvider,
    TopicConfig,
    _build_sns_lambda_event,
    _build_sns_sqs_envelope,
)
from ldk.providers.sns.routes import create_sns_app
from ldk.providers.sns.topic import LocalTopic

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_compute_mock(payload: dict | None = None, error: str | None = None) -> ICompute:
    """Return a mock ICompute whose ``invoke`` resolves to the given result."""
    mock = AsyncMock(spec=ICompute)
    mock.invoke.return_value = InvocationResult(
        payload=payload,
        error=error,
        duration_ms=1.0,
        request_id="test-request-id",
    )
    return mock


def _make_queue_mock() -> IQueue:
    """Return a mock IQueue."""
    mock = AsyncMock(spec=IQueue)
    mock.send_message.return_value = "mock-sqs-message-id"
    return mock


def _topic_configs() -> list[TopicConfig]:
    return [
        TopicConfig(
            topic_name="my-topic",
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
        ),
        TopicConfig(
            topic_name="other-topic",
            topic_arn="arn:aws:sns:us-east-1:000000000000:other-topic",
        ),
    ]


async def _started_provider(
    topics: list[TopicConfig] | None = None,
) -> SnsProvider:
    provider = SnsProvider(topics=topics or _topic_configs())
    await provider.start()
    return provider


def _client(app) -> httpx.AsyncClient:
    transport = httpx.ASGITransport(app=app)  # type: ignore[arg-type]
    return httpx.AsyncClient(transport=transport, base_url="http://testserver")


# ===========================================================================
# LocalTopic tests
# ===========================================================================


class TestLocalTopicPublishAndSubscribe:
    """Test LocalTopic publish and subscribe operations."""

    @pytest.mark.asyncio
    async def test_add_subscription_returns_arn(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        arn = await topic.add_subscription(protocol="lambda", endpoint="my-func")
        assert arn.startswith("arn:aws:sns:us-east-1:000000000000:test:")
        assert len(topic.subscribers) == 1

    @pytest.mark.asyncio
    async def test_publish_returns_uuid_message_id(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        message_id = await topic.publish(message="hello")
        assert message_id  # non-empty string
        # UUID format: 8-4-4-4-12
        parts = message_id.split("-")
        assert len(parts) == 5

    @pytest.mark.asyncio
    async def test_multiple_subscribers(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        arn1 = await topic.add_subscription(protocol="lambda", endpoint="func-a")
        arn2 = await topic.add_subscription(protocol="sqs", endpoint="queue-b")
        assert arn1 != arn2
        assert len(topic.subscribers) == 2

    @pytest.mark.asyncio
    async def test_get_matching_subscribers_no_filter(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        await topic.add_subscription(protocol="lambda", endpoint="func-a")
        await topic.add_subscription(protocol="sqs", endpoint="queue-b")
        matching = topic.get_matching_subscribers()
        assert len(matching) == 2

    @pytest.mark.asyncio
    async def test_get_matching_subscribers_with_filter(self) -> None:
        topic = LocalTopic("test", "arn:aws:sns:us-east-1:000000000000:test")
        await topic.add_subscription(
            protocol="lambda",
            endpoint="func-a",
            filter_policy={"color": ["red"]},
        )
        await topic.add_subscription(protocol="sqs", endpoint="queue-b")

        attrs = {"color": {"DataType": "String", "StringValue": "blue"}}
        matching = topic.get_matching_subscribers(attrs)
        # Only the unfiltered sub matches
        assert len(matching) == 1
        assert matching[0].endpoint == "queue-b"


# ===========================================================================
# SnsProvider lifecycle tests
# ===========================================================================


class TestSnsProviderLifecycle:
    """Test SnsProvider lifecycle methods."""

    def test_name(self) -> None:
        provider = SnsProvider(topics=[])
        assert provider.name == "sns"

    @pytest.mark.asyncio
    async def test_health_check_before_start(self) -> None:
        provider = SnsProvider(topics=_topic_configs())
        assert await provider.health_check() is False

    @pytest.mark.asyncio
    async def test_start_sets_running(self) -> None:
        provider = await _started_provider()
        assert await provider.health_check() is True

    @pytest.mark.asyncio
    async def test_stop_clears_topics(self) -> None:
        provider = await _started_provider()
        await provider.stop()
        assert await provider.health_check() is False

    @pytest.mark.asyncio
    async def test_list_topics(self) -> None:
        provider = await _started_provider()
        topics = provider.list_topics()
        assert len(topics) == 2
        names = {t.topic_name for t in topics}
        assert names == {"my-topic", "other-topic"}


# ===========================================================================
# SnsProvider publish and subscribe
# ===========================================================================


class TestSnsProviderPublishSubscribe:
    """Test SnsProvider publish and subscribe operations."""

    @pytest.mark.asyncio
    async def test_subscribe_returns_arn(self) -> None:
        provider = await _started_provider()
        arn = await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="my-func",
        )
        assert "my-topic" in arn

    @pytest.mark.asyncio
    async def test_publish_returns_message_id(self) -> None:
        provider = await _started_provider()
        message_id = await provider.publish(
            topic_name="my-topic",
            message="hello world",
        )
        assert message_id
        parts = message_id.split("-")
        assert len(parts) == 5

    @pytest.mark.asyncio
    async def test_publish_nonexistent_topic_raises(self) -> None:
        provider = await _started_provider()
        with pytest.raises(KeyError, match="Topic not found"):
            await provider.publish(topic_name="no-such-topic", message="oops")


# ===========================================================================
# Lambda subscription dispatch
# ===========================================================================


class TestLambdaSubscriptionDispatch:
    """Test that Lambda subscriptions invoke the compute handler with SNS event."""

    @pytest.mark.asyncio
    async def test_lambda_dispatch_invokes_compute(self) -> None:
        provider = await _started_provider()
        mock_compute = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers({"my-func": mock_compute})

        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="my-func",
        )
        await provider.publish(
            topic_name="my-topic",
            message="test message",
            subject="Test Subject",
        )

        # Allow the asyncio.create_task to execute
        await asyncio.sleep(0.05)

        mock_compute.invoke.assert_called_once()
        call_args = mock_compute.invoke.call_args
        event = call_args[0][0]
        context = call_args[0][1]

        # Verify SNS event format
        assert "Records" in event
        assert len(event["Records"]) == 1
        record = event["Records"][0]
        assert record["EventSource"] == "aws:sns"
        assert record["Sns"]["Message"] == "test message"
        assert record["Sns"]["Subject"] == "Test Subject"
        assert record["Sns"]["TopicArn"] == "arn:aws:sns:us-east-1:000000000000:my-topic"
        assert record["Sns"]["MessageId"]

        # Verify context
        assert isinstance(context, LambdaContext)
        assert context.function_name == "my-func"

    @pytest.mark.asyncio
    async def test_lambda_dispatch_missing_compute_logs_error(self) -> None:
        """When no compute provider is registered, dispatch should not raise."""
        provider = await _started_provider()
        # No compute providers set

        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="nonexistent-func",
        )
        # Should not raise
        await provider.publish(topic_name="my-topic", message="hello")
        await asyncio.sleep(0.05)


# ===========================================================================
# SQS subscription dispatch
# ===========================================================================


class TestSqsSubscriptionDispatch:
    """Test that SQS subscriptions forward messages wrapped in SNS envelope."""

    @pytest.mark.asyncio
    async def test_sqs_dispatch_sends_message(self) -> None:
        provider = await _started_provider()
        mock_queue = _make_queue_mock()
        provider.set_queue_provider(mock_queue)

        await provider.subscribe(
            topic_name="my-topic",
            protocol="sqs",
            endpoint="arn:aws:sqs:us-east-1:000000000000:my-queue",
        )
        await provider.publish(
            topic_name="my-topic",
            message="sqs test message",
            subject="SQS Subject",
        )

        await asyncio.sleep(0.05)

        mock_queue.send_message.assert_called_once()
        call_kwargs = mock_queue.send_message.call_args
        assert call_kwargs[1]["queue_name"] == "my-queue"

        # The body should be a JSON SNS envelope
        body = json.loads(call_kwargs[1]["message_body"])
        assert body["Type"] == "Notification"
        assert body["Message"] == "sqs test message"
        assert body["Subject"] == "SQS Subject"
        assert body["TopicArn"] == "arn:aws:sns:us-east-1:000000000000:my-topic"

    @pytest.mark.asyncio
    async def test_sqs_dispatch_no_queue_provider_logs_error(self) -> None:
        """When no queue provider is configured, dispatch should not raise."""
        provider = await _started_provider()
        # No queue provider set

        await provider.subscribe(
            topic_name="my-topic",
            protocol="sqs",
            endpoint="arn:aws:sqs:us-east-1:000000000000:my-queue",
        )
        # Should not raise
        await provider.publish(topic_name="my-topic", message="hello")
        await asyncio.sleep(0.05)


# ===========================================================================
# Fan-out to multiple subscribers
# ===========================================================================


class TestFanOut:
    """Test fan-out to multiple subscribers."""

    @pytest.mark.asyncio
    async def test_fan_out_to_multiple_subscribers(self) -> None:
        provider = await _started_provider()
        compute_a = _make_compute_mock(payload={"statusCode": 200})
        compute_b = _make_compute_mock(payload={"statusCode": 200})
        mock_queue = _make_queue_mock()
        provider.set_compute_providers({"func-a": compute_a, "func-b": compute_b})
        provider.set_queue_provider(mock_queue)

        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="func-a")
        await provider.subscribe(topic_name="my-topic", protocol="lambda", endpoint="func-b")
        await provider.subscribe(
            topic_name="my-topic",
            protocol="sqs",
            endpoint="arn:aws:sqs:us-east-1:000000000000:q1",
        )

        await provider.publish(topic_name="my-topic", message="fan-out test")
        await asyncio.sleep(0.05)

        compute_a.invoke.assert_called_once()
        compute_b.invoke.assert_called_once()
        mock_queue.send_message.assert_called_once()

    @pytest.mark.asyncio
    async def test_fan_out_respects_filter_policy(self) -> None:
        provider = await _started_provider()
        compute_match = _make_compute_mock(payload={"statusCode": 200})
        compute_no_match = _make_compute_mock(payload={"statusCode": 200})
        provider.set_compute_providers(
            {
                "match-func": compute_match,
                "no-match-func": compute_no_match,
            }
        )

        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="match-func",
            filter_policy={"color": ["red"]},
        )
        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="no-match-func",
            filter_policy={"color": ["blue"]},
        )

        await provider.publish(
            topic_name="my-topic",
            message="filtered message",
            message_attributes={
                "color": {"DataType": "String", "StringValue": "red"},
            },
        )
        await asyncio.sleep(0.05)

        compute_match.invoke.assert_called_once()
        compute_no_match.invoke.assert_not_called()


# ===========================================================================
# Filter policy matching tests
# ===========================================================================


class TestFilterPolicyExactStringMatch:
    """Test exact string matching in filter policies."""

    def test_exact_match_passes(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "red"}}
        policy = {"color": ["red", "blue"]}
        assert matches_filter_policy(attrs, policy) is True

    def test_exact_match_fails(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "green"}}
        policy = {"color": ["red", "blue"]}
        assert matches_filter_policy(attrs, policy) is False

    def test_missing_attribute_fails(self) -> None:
        attrs = {"size": {"DataType": "String", "StringValue": "large"}}
        policy = {"color": ["red"]}
        assert matches_filter_policy(attrs, policy) is False


class TestFilterPolicyNumericComparison:
    """Test numeric comparison in filter policies."""

    def test_greater_than_or_equal(self) -> None:
        attrs = {"price": {"DataType": "Number", "StringValue": "150"}}
        policy = {"price": [{"numeric": [">=", 100]}]}
        assert matches_filter_policy(attrs, policy) is True

    def test_less_than(self) -> None:
        attrs = {"price": {"DataType": "Number", "StringValue": "50"}}
        policy = {"price": [{"numeric": [">=", 100]}]}
        assert matches_filter_policy(attrs, policy) is False

    def test_range(self) -> None:
        attrs = {"price": {"DataType": "Number", "StringValue": "150"}}
        policy = {"price": [{"numeric": [">=", 100, "<", 200]}]}
        assert matches_filter_policy(attrs, policy) is True

    def test_range_out_of_bounds(self) -> None:
        attrs = {"price": {"DataType": "Number", "StringValue": "250"}}
        policy = {"price": [{"numeric": [">=", 100, "<", 200]}]}
        assert matches_filter_policy(attrs, policy) is False

    def test_numeric_equality(self) -> None:
        attrs = {"count": {"DataType": "Number", "StringValue": "42"}}
        policy = {"count": [{"numeric": ["=", 42]}]}
        assert matches_filter_policy(attrs, policy) is True


class TestFilterPolicyExistsCheck:
    """Test exists check in filter policies."""

    def test_exists_true_with_attribute_present(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "red"}}
        policy = {"color": [{"exists": True}]}
        assert matches_filter_policy(attrs, policy) is True

    def test_exists_true_with_attribute_missing(self) -> None:
        attrs = {}
        policy = {"color": [{"exists": True}]}
        assert matches_filter_policy(attrs, policy) is False

    def test_exists_false_with_attribute_missing(self) -> None:
        attrs = {}
        policy = {"color": [{"exists": False}]}
        assert matches_filter_policy(attrs, policy) is True

    def test_exists_false_with_attribute_present(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "red"}}
        policy = {"color": [{"exists": False}]}
        assert matches_filter_policy(attrs, policy) is False


class TestFilterPolicyAnythingBut:
    """Test anything-but exclusion in filter policies."""

    def test_anything_but_excludes_value(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "red"}}
        policy = {"color": [{"anything-but": ["red"]}]}
        assert matches_filter_policy(attrs, policy) is False

    def test_anything_but_passes_different_value(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "green"}}
        policy = {"color": [{"anything-but": ["red"]}]}
        assert matches_filter_policy(attrs, policy) is True

    def test_anything_but_multiple_exclusions(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "blue"}}
        policy = {"color": [{"anything-but": ["red", "blue"]}]}
        assert matches_filter_policy(attrs, policy) is False

    def test_anything_but_missing_attribute(self) -> None:
        attrs = {}
        policy = {"color": [{"anything-but": ["red"]}]}
        assert matches_filter_policy(attrs, policy) is False


class TestFilterPolicyNoFilter:
    """Test that no filter policy matches everything."""

    def test_none_filter_matches_all(self) -> None:
        attrs = {"anything": {"DataType": "String", "StringValue": "value"}}
        assert matches_filter_policy(attrs, None) is True

    def test_empty_filter_matches_all(self) -> None:
        attrs = {"anything": {"DataType": "String", "StringValue": "value"}}
        assert matches_filter_policy(attrs, {}) is True

    def test_empty_attrs_with_no_filter(self) -> None:
        assert matches_filter_policy({}, None) is True


class TestFilterPolicyMultipleConditions:
    """Test filter policies with multiple keys."""

    def test_all_keys_must_match(self) -> None:
        attrs = {
            "color": {"DataType": "String", "StringValue": "red"},
            "size": {"DataType": "String", "StringValue": "large"},
        }
        policy = {"color": ["red"], "size": ["large"]}
        assert matches_filter_policy(attrs, policy) is True

    def test_partial_match_fails(self) -> None:
        attrs = {
            "color": {"DataType": "String", "StringValue": "red"},
            "size": {"DataType": "String", "StringValue": "small"},
        }
        policy = {"color": ["red"], "size": ["large"]}
        assert matches_filter_policy(attrs, policy) is False


# ===========================================================================
# SNS event format construction
# ===========================================================================


class TestSnsEventFormat:
    """Test SNS event format builders."""

    def test_lambda_event_structure(self) -> None:
        event = _build_sns_lambda_event(
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
            message="hello",
            message_id="msg-123",
            subject="Test",
            message_attributes=None,
        )

        assert "Records" in event
        assert len(event["Records"]) == 1

        record = event["Records"][0]
        assert record["EventSource"] == "aws:sns"
        assert record["EventVersion"] == "1.0"
        assert "EventSubscriptionArn" in record

        sns = record["Sns"]
        assert sns["Type"] == "Notification"
        assert sns["MessageId"] == "msg-123"
        assert sns["TopicArn"] == "arn:aws:sns:us-east-1:000000000000:my-topic"
        assert sns["Subject"] == "Test"
        assert sns["Message"] == "hello"
        assert sns["Timestamp"]
        assert sns["MessageAttributes"] == {}

    def test_lambda_event_with_message_attributes(self) -> None:
        attrs = {"color": {"DataType": "String", "StringValue": "red"}}
        event = _build_sns_lambda_event(
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
            message="hello",
            message_id="msg-456",
            subject=None,
            message_attributes=attrs,
        )

        sns = event["Records"][0]["Sns"]
        assert "color" in sns["MessageAttributes"]
        assert sns["MessageAttributes"]["color"]["DataType"] == "String"
        assert sns["MessageAttributes"]["color"]["StringValue"] == "red"

    def test_sqs_envelope_structure(self) -> None:
        envelope = _build_sns_sqs_envelope(
            topic_arn="arn:aws:sns:us-east-1:000000000000:my-topic",
            message="sqs hello",
            message_id="msg-789",
            subject="SQS Test",
            message_attributes=None,
        )

        assert envelope["Type"] == "Notification"
        assert envelope["MessageId"] == "msg-789"
        assert envelope["TopicArn"] == "arn:aws:sns:us-east-1:000000000000:my-topic"
        assert envelope["Subject"] == "SQS Test"
        assert envelope["Message"] == "sqs hello"
        assert envelope["Timestamp"]
        assert envelope["MessageAttributes"] == {}


# ===========================================================================
# SNS routes tests (wire protocol)
# ===========================================================================


class TestSnsRoutes:
    """Test SNS HTTP wire protocol routes."""

    @pytest.mark.asyncio
    async def test_publish_action(self) -> None:
        provider = await _started_provider()
        app = create_sns_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                data={
                    "Action": "Publish",
                    "TopicArn": "arn:aws:sns:us-east-1:000000000000:my-topic",
                    "Message": "wire protocol test",
                },
            )

        assert response.status_code == 200
        assert "<MessageId>" in response.text
        assert "</PublishResponse>" in response.text

    @pytest.mark.asyncio
    async def test_subscribe_action(self) -> None:
        provider = await _started_provider()
        app = create_sns_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                data={
                    "Action": "Subscribe",
                    "TopicArn": "arn:aws:sns:us-east-1:000000000000:my-topic",
                    "Protocol": "lambda",
                    "Endpoint": "my-func",
                },
            )

        assert response.status_code == 200
        assert "<SubscriptionArn>" in response.text
        assert "</SubscribeResponse>" in response.text

    @pytest.mark.asyncio
    async def test_list_topics_action(self) -> None:
        provider = await _started_provider()
        app = create_sns_app(provider)

        async with _client(app) as client:
            response = await client.post("/", data={"Action": "ListTopics"})

        assert response.status_code == 200
        assert "<ListTopicsResponse>" in response.text
        assert "my-topic" in response.text
        assert "other-topic" in response.text

    @pytest.mark.asyncio
    async def test_list_subscriptions_action(self) -> None:
        provider = await _started_provider()
        await provider.subscribe(
            topic_name="my-topic",
            protocol="lambda",
            endpoint="func-a",
        )
        app = create_sns_app(provider)

        async with _client(app) as client:
            response = await client.post("/", data={"Action": "ListSubscriptions"})

        assert response.status_code == 200
        assert "<ListSubscriptionsResponse>" in response.text
        assert "func-a" in response.text

    @pytest.mark.asyncio
    async def test_create_topic_action(self) -> None:
        provider = await _started_provider()
        app = create_sns_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                data={"Action": "CreateTopic", "Name": "my-topic"},
            )

        assert response.status_code == 200
        assert "<TopicArn>" in response.text
        assert "my-topic" in response.text

    @pytest.mark.asyncio
    async def test_unknown_action_returns_400(self) -> None:
        provider = await _started_provider()
        app = create_sns_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                data={"Action": "Bogus"},
            )

        assert response.status_code == 400
        assert "InvalidAction" in response.text

    @pytest.mark.asyncio
    async def test_publish_with_message_attributes(self) -> None:
        provider = await _started_provider()
        app = create_sns_app(provider)

        async with _client(app) as client:
            response = await client.post(
                "/",
                data={
                    "Action": "Publish",
                    "TopicArn": "arn:aws:sns:us-east-1:000000000000:my-topic",
                    "Message": "attr test",
                    "MessageAttributes.entry.1.Name": "color",
                    "MessageAttributes.entry.1.Value.DataType": "String",
                    "MessageAttributes.entry.1.Value.StringValue": "red",
                },
            )

        assert response.status_code == 200
        assert "<MessageId>" in response.text
