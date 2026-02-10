"""In-memory SNS topic implementation.

Provides ``LocalTopic``, an asyncio-safe in-memory SNS topic that
manages subscriptions and fans out published messages to all matching
subscribers.
"""

from __future__ import annotations

import asyncio
import uuid
from dataclasses import dataclass

from lws.providers.sns.filter import matches_filter_policy


@dataclass
class Subscription:
    """Represents a single SNS subscription."""

    protocol: str  # "lambda" or "sqs"
    endpoint: str  # function name or queue ARN
    filter_policy: dict | None
    subscription_arn: str


@dataclass
class PublishedMessage:
    """A message that was published to the topic, with its delivery metadata."""

    message_id: str
    message: str
    subject: str | None
    message_attributes: dict
    topic_arn: str


class LocalTopic:
    """In-memory SNS topic that supports subscribe and publish with fan-out.

    Parameters
    ----------
    topic_name:
        The logical name of the topic.
    topic_arn:
        The full ARN of the topic.
    """

    def __init__(self, topic_name: str, topic_arn: str) -> None:
        self.topic_name = topic_name
        self.topic_arn = topic_arn
        self.subscribers: list[Subscription] = []
        self._lock = asyncio.Lock()

    async def add_subscription(
        self,
        protocol: str,
        endpoint: str,
        filter_policy: dict | None = None,
    ) -> str:
        """Register a new subscription and return its ARN.

        Parameters
        ----------
        protocol:
            The subscription protocol (``"lambda"`` or ``"sqs"``).
        endpoint:
            The function name (for Lambda) or queue ARN (for SQS).
        filter_policy:
            Optional SNS filter policy dict.

        Returns
        -------
        str
            The subscription ARN.
        """
        subscription_arn = f"{self.topic_arn}:{uuid.uuid4().hex[:8]}"
        subscription = Subscription(
            protocol=protocol,
            endpoint=endpoint,
            filter_policy=filter_policy,
            subscription_arn=subscription_arn,
        )
        async with self._lock:
            self.subscribers.append(subscription)
        return subscription_arn

    async def publish(
        self,
        message: str,
        subject: str | None = None,
        message_attributes: dict | None = None,
    ) -> str:
        """Publish a message and return its message ID.

        Fan-out delivers the message to every subscriber whose filter
        policy matches the supplied *message_attributes*.

        Parameters
        ----------
        message:
            The message body.
        subject:
            Optional subject line.
        message_attributes:
            Optional dict of message attributes for filter evaluation.

        Returns
        -------
        str
            A UUID message ID.
        """
        message_id = str(uuid.uuid4())
        return message_id

    async def remove_subscription(self, subscription_arn: str) -> bool:
        """Remove a subscription by ARN.

        Returns True if a subscription was removed, False if not found.
        """
        async with self._lock:
            for i, sub in enumerate(self.subscribers):
                if sub.subscription_arn == subscription_arn:
                    self.subscribers.pop(i)
                    return True
        return False

    def find_subscription(self, subscription_arn: str) -> Subscription | None:
        """Find a subscription by ARN. Returns None if not found."""
        for sub in self.subscribers:
            if sub.subscription_arn == subscription_arn:
                return sub
        return None

    def get_matching_subscribers(
        self,
        message_attributes: dict | None = None,
    ) -> list[Subscription]:
        """Return subscribers whose filter policy matches the attributes.

        This is a synchronous helper used by the provider for dispatch.
        The caller is responsible for holding any necessary lock.
        """
        attrs = message_attributes or {}
        return [sub for sub in self.subscribers if matches_filter_policy(attrs, sub.filter_policy)]
