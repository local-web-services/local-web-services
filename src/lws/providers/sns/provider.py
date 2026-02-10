"""SNS provider for local development.

Implements the ``Provider`` lifecycle and exposes publish/subscribe
operations.  Lambda subscriptions invoke the compute handler with an
SNS event; SQS subscriptions forward the message wrapped in an SNS
envelope.
"""

from __future__ import annotations

import asyncio
import json
import logging
import time
import uuid
from dataclasses import dataclass

from lws.interfaces.compute import ICompute, LambdaContext
from lws.interfaces.provider import Provider, ProviderStatus
from lws.interfaces.queue import IQueue
from lws.providers.sns.topic import LocalTopic

logger = logging.getLogger(__name__)


@dataclass
class TopicConfig:
    """Configuration for an SNS topic."""

    topic_name: str
    topic_arn: str


class SnsProvider(Provider):
    """In-memory SNS provider that manages topics and dispatches messages.

    Parameters
    ----------
    topics:
        List of topic configurations to create at startup.
    """

    def __init__(self, topics: list[TopicConfig] | None = None) -> None:
        self._topic_configs = topics or []
        self._topics: dict[str, LocalTopic] = {}
        self._status = ProviderStatus.STOPPED
        self._compute_providers: dict[str, ICompute] = {}
        self._queue_provider: IQueue | None = None
        self._lock = asyncio.Lock()

    # -- Provider lifecycle ---------------------------------------------------

    @property
    def name(self) -> str:
        return "sns"

    async def start(self) -> None:
        """Create topic instances and mark the provider as running."""
        async with self._lock:
            for config in self._topic_configs:
                topic = LocalTopic(
                    topic_name=config.topic_name,
                    topic_arn=config.topic_arn,
                )
                self._topics[config.topic_name] = topic
            self._status = ProviderStatus.RUNNING

    async def stop(self) -> None:
        """Clear all topics and mark the provider as stopped."""
        async with self._lock:
            self._topics.clear()
            self._status = ProviderStatus.STOPPED

    async def health_check(self) -> bool:
        return self._status is ProviderStatus.RUNNING

    # -- Cross-provider wiring ------------------------------------------------

    def set_compute_providers(self, providers: dict[str, ICompute]) -> None:
        """Register compute providers for Lambda subscription dispatch."""
        self._compute_providers = providers

    def set_queue_provider(self, provider: IQueue) -> None:
        """Register a queue provider for SQS subscription dispatch."""
        self._queue_provider = provider

    # -- Public API -----------------------------------------------------------

    async def publish(
        self,
        topic_name: str,
        message: str,
        subject: str | None = None,
        message_attributes: dict | None = None,
    ) -> str:
        """Publish a message to a topic and fan out to subscribers.

        Returns the message ID.
        """
        topic = self._get_topic(topic_name)
        message_id = await topic.publish(
            message=message,
            subject=subject,
            message_attributes=message_attributes,
        )

        # Fan-out to matching subscribers via asyncio tasks
        subscribers = topic.get_matching_subscribers(message_attributes)
        for sub in subscribers:
            asyncio.create_task(
                self._dispatch(
                    subscription=sub,
                    topic_arn=topic.topic_arn,
                    message=message,
                    message_id=message_id,
                    subject=subject,
                    message_attributes=message_attributes,
                )
            )

        return message_id

    async def subscribe(
        self,
        topic_name: str,
        protocol: str,
        endpoint: str,
        filter_policy: dict | None = None,
    ) -> str:
        """Subscribe an endpoint to a topic. Returns the subscription ARN."""
        topic = self._get_topic(topic_name)
        return await topic.add_subscription(
            protocol=protocol,
            endpoint=endpoint,
            filter_policy=filter_policy,
        )

    def get_topic(self, topic_name: str) -> LocalTopic:
        """Return the LocalTopic instance for the given name."""
        return self._get_topic(topic_name)

    def list_topics(self) -> list[LocalTopic]:
        """Return all topics managed by this provider."""
        return list(self._topics.values())

    async def create_topic(self, topic_name: str) -> str:
        """Create a topic. Idempotent — returns existing ARN if already present."""
        existing = self._topics.get(topic_name)
        if existing is not None:
            return existing.topic_arn
        topic_arn = f"arn:aws:sns:us-east-1:000000000000:{topic_name}"
        topic = LocalTopic(topic_name=topic_name, topic_arn=topic_arn)
        self._topics[topic_name] = topic
        return topic_arn

    async def delete_topic(self, topic_name: str) -> None:
        """Delete a topic. Raises KeyError if not found."""
        if topic_name not in self._topics:
            raise KeyError(f"Topic not found: {topic_name}")
        del self._topics[topic_name]

    async def get_topic_attributes(self, topic_name: str) -> dict:
        """Return topic attributes dict. Raises KeyError if not found."""
        topic = self._topics.get(topic_name)
        if topic is None:
            raise KeyError(f"Topic not found: {topic_name}")
        attrs: dict[str, str] = {
            "TopicArn": topic.topic_arn,
            "DisplayName": topic.topic_name,
            "SubscriptionsConfirmed": str(len(topic.subscribers)),
            "Policy": '{"Version":"2012-10-17","Statement":[]}',
        }
        # Overlay any attributes set via SetTopicAttributes
        custom = getattr(topic, "_custom_attrs", None)
        if custom:
            attrs.update(custom)
        return attrs

    async def unsubscribe(self, subscription_arn: str) -> bool:
        """Remove a subscription by ARN across all topics.

        Returns True if a subscription was removed, False if not found.
        """
        for topic in self._topics.values():
            if await topic.remove_subscription(subscription_arn):
                return True
        return False

    def find_subscription(self, subscription_arn: str) -> tuple:
        """Find a subscription by ARN across all topics.

        Returns a tuple of (Subscription, LocalTopic) or (None, None) if not found.
        """
        for topic in self._topics.values():
            sub = topic.find_subscription(subscription_arn)
            if sub is not None:
                return sub, topic
        return None, None

    def list_subscriptions_by_topic(self, topic_name: str) -> list:
        """Return all subscriptions for a specific topic. Raises KeyError if not found."""
        topic = self._topics.get(topic_name)
        if topic is None:
            raise KeyError(f"Topic not found: {topic_name}")
        return list(topic.subscribers)

    async def get_subscription_attributes(self, subscription_arn: str) -> dict:
        """Return subscription attributes dict. Raises KeyError if not found."""
        sub, topic = self.find_subscription(subscription_arn)
        if sub is None or topic is None:
            raise KeyError(f"Subscription not found: {subscription_arn}")
        attrs: dict[str, str] = {
            "SubscriptionArn": sub.subscription_arn,
            "TopicArn": topic.topic_arn,
            "Protocol": sub.protocol,
            "Endpoint": sub.endpoint,
            "Owner": "000000000000",
            "ConfirmationWasAuthenticated": "true",
            "PendingConfirmation": "false",
        }
        if sub.filter_policy is not None:
            import json

            attrs["FilterPolicy"] = json.dumps(sub.filter_policy)
        # Overlay any custom attributes set via SetSubscriptionAttributes
        custom = getattr(sub, "_custom_attrs", None)
        if custom:
            attrs.update(custom)
        return attrs

    async def set_subscription_attribute(
        self, subscription_arn: str, attr_name: str, attr_value: str
    ) -> None:
        """Set a single subscription attribute. Raises KeyError if not found."""
        sub, _topic = self.find_subscription(subscription_arn)
        if sub is None:
            raise KeyError(f"Subscription not found: {subscription_arn}")
        if not hasattr(sub, "_custom_attrs"):
            sub._custom_attrs = {}  # type: ignore[attr-defined]
        sub._custom_attrs[attr_name] = attr_value  # type: ignore[attr-defined]

    async def set_topic_attribute(self, topic_name: str, attr_name: str, attr_value: str) -> None:
        """Set a single topic attribute. Raises KeyError if not found."""
        topic = self._topics.get(topic_name)
        if topic is None:
            raise KeyError(f"Topic not found: {topic_name}")
        if not hasattr(topic, "_custom_attrs"):
            topic._custom_attrs = {}  # type: ignore[attr-defined]
        topic._custom_attrs[attr_name] = attr_value  # type: ignore[attr-defined]

    # -- Dispatch helpers -----------------------------------------------------

    async def _dispatch(
        self,
        subscription: object,
        topic_arn: str,
        message: str,
        message_id: str,
        subject: str | None,
        message_attributes: dict | None,
    ) -> None:
        """Route a published message to a single subscriber."""
        from lws.providers.sns.topic import Subscription

        sub: Subscription = subscription  # type: ignore[assignment]
        try:
            if sub.protocol == "lambda":
                await self._dispatch_lambda(
                    endpoint=sub.endpoint,
                    topic_arn=topic_arn,
                    message=message,
                    message_id=message_id,
                    subject=subject,
                    message_attributes=message_attributes,
                )
            elif sub.protocol == "sqs":
                await self._dispatch_sqs(
                    endpoint=sub.endpoint,
                    topic_arn=topic_arn,
                    message=message,
                    message_id=message_id,
                    subject=subject,
                    message_attributes=message_attributes,
                )
            else:
                logger.warning("Unsupported subscription protocol: %s", sub.protocol)
        except Exception:
            logger.exception(
                "Failed to dispatch message %s to %s (%s)",
                message_id,
                sub.endpoint,
                sub.protocol,
            )

    async def _dispatch_lambda(
        self,
        endpoint: str,
        topic_arn: str,
        message: str,
        message_id: str,
        subject: str | None,
        message_attributes: dict | None,
    ) -> None:
        """Invoke a Lambda function with an SNS event."""
        compute = self._compute_providers.get(endpoint)
        if compute is None:
            logger.error("No compute provider found for function: %s", endpoint)
            return

        event = _build_sns_lambda_event(
            topic_arn=topic_arn,
            message=message,
            message_id=message_id,
            subject=subject,
            message_attributes=message_attributes,
        )
        context = LambdaContext(
            function_name=endpoint,
            memory_limit_in_mb=128,
            timeout_seconds=30,
            aws_request_id=str(uuid.uuid4()),
            invoked_function_arn=f"arn:aws:lambda:us-east-1:000000000000:function:{endpoint}",
        )
        await compute.invoke(event, context)

    async def _dispatch_sqs(
        self,
        endpoint: str,
        topic_arn: str,
        message: str,
        message_id: str,
        subject: str | None,
        message_attributes: dict | None,
    ) -> None:
        """Send an SNS-wrapped message to an SQS queue."""
        if self._queue_provider is None:
            logger.error("No queue provider configured for SQS dispatch")
            return

        # Extract queue name from ARN (last segment)
        queue_name = endpoint.rsplit(":", 1)[-1] if ":" in endpoint else endpoint

        envelope = _build_sns_sqs_envelope(
            topic_arn=topic_arn,
            message=message,
            message_id=message_id,
            subject=subject,
            message_attributes=message_attributes,
        )

        await self._queue_provider.send_message(
            queue_name=queue_name,
            message_body=json.dumps(envelope),
        )

    # -- Internal helpers -----------------------------------------------------

    def _get_topic(self, topic_name: str) -> LocalTopic:
        """Retrieve a topic by name, raising KeyError if not found."""
        topic = self._topics.get(topic_name)
        if topic is None:
            raise KeyError(f"Topic not found: {topic_name}")
        return topic


# ---------------------------------------------------------------------------
# Event format builders
# ---------------------------------------------------------------------------


def _build_sns_lambda_event(
    topic_arn: str,
    message: str,
    message_id: str,
    subject: str | None,
    message_attributes: dict | None,
) -> dict:
    """Build an SNS event in the format Lambda expects.

    Shape: ``{"Records": [{"EventSource": "aws:sns", "Sns": {...}}]}``
    """
    timestamp = time.strftime("%Y-%m-%dT%H:%M:%S.000Z", time.gmtime())
    sns_record: dict = {
        "Type": "Notification",
        "MessageId": message_id,
        "TopicArn": topic_arn,
        "Subject": subject,
        "Message": message,
        "Timestamp": timestamp,
        "MessageAttributes": _format_message_attributes(message_attributes),
    }

    return {
        "Records": [
            {
                "EventSource": "aws:sns",
                "EventVersion": "1.0",
                "EventSubscriptionArn": f"{topic_arn}:subscription",
                "Sns": sns_record,
            }
        ]
    }


def _build_sns_sqs_envelope(
    topic_arn: str,
    message: str,
    message_id: str,
    subject: str | None,
    message_attributes: dict | None,
) -> dict:
    """Build the SNS notification envelope that wraps an SQS message body.

    This is the JSON object that appears as the SQS message body when
    SNS delivers to an SQS subscription.
    """
    timestamp = time.strftime("%Y-%m-%dT%H:%M:%S.000Z", time.gmtime())
    return {
        "Type": "Notification",
        "MessageId": message_id,
        "TopicArn": topic_arn,
        "Subject": subject,
        "Message": message,
        "Timestamp": timestamp,
        "MessageAttributes": _format_message_attributes(message_attributes),
    }


def _format_message_attributes(attrs: dict | None) -> dict:
    """Normalise message attributes to the SNS wire format.

    If attributes are already in ``{"DataType": ..., "StringValue": ...}``
    form, return as-is.  Otherwise wrap plain string values.
    """
    if not attrs:
        return {}

    result: dict = {}
    for key, value in attrs.items():
        if isinstance(value, dict) and "DataType" in value:
            result[key] = value
        else:
            result[key] = {
                "Type": "String",
                "Value": str(value),
            }
    return result
