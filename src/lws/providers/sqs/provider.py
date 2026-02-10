"""SQS provider implementing the IQueue interface.

Wraps one or more ``LocalQueue`` instances and exposes them through the
standard ``IQueue`` abstract interface so the rest of LDK can treat SQS
as a pluggable provider.
"""

from __future__ import annotations

import time
from dataclasses import dataclass, field

from lws.interfaces.queue import IQueue
from lws.providers.sqs.queue import LocalQueue

_FAKE_ACCOUNT = "000000000000"
_FAKE_REGION = "us-east-1"


@dataclass
class RedrivePolicy:
    """Dead-letter queue redrive configuration."""

    dead_letter_queue_name: str
    max_receive_count: int = 5


@dataclass
class QueueConfig:
    """Configuration for a single SQS queue."""

    queue_name: str
    visibility_timeout: int = 30
    is_fifo: bool = False
    content_based_dedup: bool = False
    redrive_policy: RedrivePolicy | None = None
    tags: dict[str, str] = field(default_factory=dict)


class SqsProvider(IQueue):
    """In-memory SQS provider backed by ``LocalQueue`` instances.

    Manages creation and lifecycle of local queues and implements the
    ``IQueue`` interface for interoperability with the rest of LDK.
    """

    def __init__(self, queues: list[QueueConfig] | None = None) -> None:
        self._configs = {q.queue_name: q for q in (queues or [])}
        self._queues: dict[str, LocalQueue] = {}
        self._running = False

    # ------------------------------------------------------------------
    # Provider lifecycle
    # ------------------------------------------------------------------

    @property
    def name(self) -> str:
        return "sqs"

    async def start(self) -> None:
        """Create ``LocalQueue`` instances for each configured queue."""
        # First pass: create all queues without DLQ links
        for config in self._configs.values():
            self._queues[config.queue_name] = LocalQueue(
                queue_name=config.queue_name,
                visibility_timeout=config.visibility_timeout,
                is_fifo=config.is_fifo,
                content_based_dedup=config.content_based_dedup,
            )

        # Second pass: wire up redrive policies (DLQ references)
        for config in self._configs.values():
            if config.redrive_policy is not None:
                dlq_name = config.redrive_policy.dead_letter_queue_name
                dlq = self._queues.get(dlq_name)
                if dlq is not None:
                    queue = self._queues[config.queue_name]
                    queue.dead_letter_queue = dlq
                    queue.max_receive_count = config.redrive_policy.max_receive_count

        self._running = True

    async def stop(self) -> None:
        """Stop the provider and release resources."""
        self._queues.clear()
        self._running = False

    async def health_check(self) -> bool:
        """Return *True* when the provider is running."""
        return self._running

    # ------------------------------------------------------------------
    # IQueue implementation
    # ------------------------------------------------------------------

    async def send_message(
        self,
        queue_name: str,
        message_body: str,
        message_attributes: dict | None = None,
        delay_seconds: int = 0,
    ) -> str:
        """Send a message to the named queue. Returns the message ID."""
        queue = self._get_queue(queue_name)
        return await queue.send_message(
            body=message_body,
            message_attributes=message_attributes,
            delay_seconds=delay_seconds,
        )

    async def receive_messages(
        self,
        queue_name: str,
        max_messages: int = 1,
        wait_time_seconds: int = 0,
    ) -> list[dict]:
        """Receive messages from the named queue.

        Returns a list of dicts matching the SQS response shape.
        """
        queue = self._get_queue(queue_name)
        raw = await queue.receive_messages(
            max_messages=max_messages,
            wait_time_seconds=wait_time_seconds,
        )
        return [
            {
                "MessageId": msg.message_id,
                "ReceiptHandle": msg.receipt_handle,
                "Body": msg.body,
                "MD5OfBody": LocalQueue.md5_of_body(msg.body),
                "Attributes": {
                    "ApproximateReceiveCount": str(msg.receive_count),
                    "SentTimestamp": str(int(msg.sent_timestamp * 1000)),
                },
                "MessageAttributes": msg.message_attributes,
            }
            for msg in raw
        ]

    async def delete_message(self, queue_name: str, receipt_handle: str) -> None:
        """Delete a message from the named queue."""
        queue = self._get_queue(queue_name)
        await queue.delete_message(receipt_handle)

    # ------------------------------------------------------------------
    # Queue management helpers
    # ------------------------------------------------------------------

    def get_queue(self, queue_name: str) -> LocalQueue | None:
        """Return the ``LocalQueue`` for *queue_name*, or *None*."""
        return self._queues.get(queue_name)

    def create_queue_from_config(self, config: QueueConfig) -> LocalQueue:
        """Dynamically create a new queue from *config*."""
        # Idempotent: if queue already exists, return it
        existing = self._queues.get(config.queue_name)
        if existing is not None:
            return existing
        queue = LocalQueue(
            queue_name=config.queue_name,
            visibility_timeout=config.visibility_timeout,
            is_fifo=config.is_fifo,
            content_based_dedup=config.content_based_dedup,
        )
        self._queues[config.queue_name] = queue
        self._configs[config.queue_name] = config
        return queue

    # ------------------------------------------------------------------
    # IQueue management interface
    # ------------------------------------------------------------------

    async def create_queue(self, queue_name: str, attributes: dict | None = None) -> str:
        """Create a queue. Returns the queue URL. Idempotent per AWS behaviour."""
        attrs = attributes or {}
        is_fifo = queue_name.endswith(".fifo")
        visibility_timeout = int(attrs.get("VisibilityTimeout", "30"))
        content_based_dedup = str(attrs.get("ContentBasedDeduplication", "false")).lower() == "true"

        config = QueueConfig(
            queue_name=queue_name,
            visibility_timeout=visibility_timeout,
            is_fifo=is_fifo,
            content_based_dedup=content_based_dedup,
        )
        self.create_queue_from_config(config)
        return f"http://localhost:4566/{_FAKE_ACCOUNT}/{queue_name}"

    async def delete_queue(self, queue_name: str) -> None:
        """Delete a queue. Raises KeyError if not found."""
        if queue_name not in self._queues:
            raise KeyError(f"Queue not found: {queue_name}")
        del self._queues[queue_name]
        self._configs.pop(queue_name, None)

    async def get_queue_attributes(self, queue_name: str) -> dict:
        """Return queue attributes dict. Raises KeyError if not found."""
        queue = self._queues.get(queue_name)
        if queue is None:
            raise KeyError(f"Queue not found: {queue_name}")
        attrs: dict[str, str] = {
            "QueueArn": f"arn:aws:sqs:{_FAKE_REGION}:{_FAKE_ACCOUNT}:{queue_name}",
            "ApproximateNumberOfMessages": str(len(queue._messages)),
            "VisibilityTimeout": str(queue.visibility_timeout),
            "CreatedTimestamp": str(int(time.time())),
            "LastModifiedTimestamp": str(int(time.time())),
        }
        if queue.is_fifo:
            attrs["FifoQueue"] = "true"
            attrs["ContentBasedDeduplication"] = str(queue.content_based_dedup).lower()
        return attrs

    async def list_queues(self) -> list[str]:
        """Return sorted list of queue names."""
        return sorted(self._queues.keys())

    async def purge_queue(self, queue_name: str) -> None:
        """Purge all messages from a queue. Raises KeyError if not found."""
        queue = self._queues.get(queue_name)
        if queue is None:
            raise KeyError(f"Queue not found: {queue_name}")
        async with queue._lock:
            queue._messages.clear()

    # ------------------------------------------------------------------
    # Internal
    # ------------------------------------------------------------------

    def _get_queue(self, queue_name: str) -> LocalQueue:
        """Look up a queue by name, raising ``KeyError`` if missing."""
        queue = self._queues.get(queue_name)
        if queue is None:
            raise KeyError(f"Queue not found: {queue_name}")
        return queue
