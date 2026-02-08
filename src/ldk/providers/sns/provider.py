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

from ldk.interfaces.compute import ICompute, LambdaContext
from ldk.interfaces.provider import Provider, ProviderStatus
from ldk.interfaces.queue import IQueue
from ldk.providers.sns.topic import LocalTopic

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

    def __init__(self, topics: list[TopicConfig]) -> None:
        self._topic_configs = topics
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
        from ldk.providers.sns.topic import Subscription

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
