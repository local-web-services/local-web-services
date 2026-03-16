"""In-memory SQS queue implementation.

Provides ``LocalQueue``, an asyncio-safe in-memory message queue that
faithfully emulates SQS semantics including visibility timeout, FIFO
ordering, content-based deduplication, and dead-letter queue routing.
"""

from __future__ import annotations

import asyncio
import hashlib
import time
import uuid
from dataclasses import dataclass, field


@dataclass
class SqsMessage:
    """Represents a single SQS message in the local queue."""

    message_id: str
    body: str
    attributes: dict[str, str] = field(default_factory=dict)
    message_attributes: dict = field(default_factory=dict)
    receipt_handle: str | None = None
    receive_count: int = 0
    sent_timestamp: float = 0.0
    visibility_timeout_until: float = 0.0
    message_group_id: str | None = None
    message_dedup_id: str | None = None


class LocalQueue:
    """In-memory message queue that emulates core SQS behaviour.

    Parameters
    ----------
    queue_name:
        Logical name of the queue.
    visibility_timeout:
        Default visibility timeout in seconds for received messages.
    is_fifo:
        Whether this queue uses FIFO semantics.
    content_based_dedup:
        When *True* and *is_fifo* is also *True*, automatically derive
        a deduplication ID from the SHA-256 hash of the message body.
    dead_letter_queue:
        An optional ``LocalQueue`` to route messages that exceed
        *max_receive_count*.
    max_receive_count:
        Number of receives before routing to the dead-letter queue.
    """

    def __init__(
        self,
        queue_name: str,
        visibility_timeout: int = 30,
        is_fifo: bool = False,
        content_based_dedup: bool = False,
        dead_letter_queue: LocalQueue | None = None,
        max_receive_count: int = 0,
    ) -> None:
        self.queue_name = queue_name
        self.visibility_timeout = visibility_timeout
        self.is_fifo = is_fifo
        self.content_based_dedup = content_based_dedup
        self.dead_letter_queue = dead_letter_queue
        self.max_receive_count = max_receive_count

        self._messages: list[SqsMessage] = []
        self._lock = asyncio.Lock()
        self._message_available = asyncio.Event()

        # FIFO deduplication: maps dedup_id -> expiry monotonic time
        self._dedup_cache: dict[str, float] = {}

    @property
    def messages(self) -> list[SqsMessage]:
        """Return the messages list."""
        return self._messages

    @property
    def lock(self) -> asyncio.Lock:
        """Return the queue lock."""
        return self._lock

    # ------------------------------------------------------------------
    # Send
    # ------------------------------------------------------------------

    async def send_message(
        self,
        body: str,
        message_attributes: dict | None = None,
        delay_seconds: int = 0,
        message_group_id: str | None = None,
        message_dedup_id: str | None = None,
    ) -> str:
        """Enqueue a message and return its ``message_id``."""
        async with self._lock:
            dedup_id = self._resolve_dedup_id(body, message_dedup_id)
            if dedup_id is not None and self._is_duplicate(dedup_id):
                # Return existing message_id for a duplicate within the window
                return self._find_dedup_message_id(dedup_id)

            message_id = str(uuid.uuid4())
            now = time.monotonic()
            msg = SqsMessage(
                message_id=message_id,
                body=body,
                message_attributes=message_attributes or {},
                attributes={"ApproximateReceiveCount": "0"},
                sent_timestamp=time.time(),
                message_group_id=message_group_id,
                message_dedup_id=dedup_id,
            )
            if delay_seconds > 0:
                msg.visibility_timeout_until = now + delay_seconds

            self._messages.append(msg)

            if dedup_id is not None:
                self._dedup_cache[dedup_id] = now + 300  # 5-minute window

            self._message_available.set()
            return message_id

    # ------------------------------------------------------------------
    # Receive
    # ------------------------------------------------------------------

    async def receive_messages(
        self,
        max_messages: int = 1,
        wait_time_seconds: int = 0,
    ) -> list[SqsMessage]:
        """Receive up to *max_messages* visible messages.

        Supports long polling via *wait_time_seconds*.
        """
        deadline = time.monotonic() + wait_time_seconds if wait_time_seconds > 0 else 0.0

        while True:
            async with self._lock:
                self._purge_dedup_cache()
                messages = self._collect_visible(max_messages)
                if messages:
                    return messages

            # Short polling -- return immediately with empty list
            if wait_time_seconds <= 0:
                return []

            # Long polling -- wait for a signal or timeout
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                return []

            self._message_available.clear()
            try:
                await asyncio.wait_for(self._message_available.wait(), timeout=remaining)
            except TimeoutError:
                # Final attempt after timeout
                async with self._lock:
                    return self._collect_visible(max_messages)

    # ------------------------------------------------------------------
    # Delete
    # ------------------------------------------------------------------

    async def delete_message(self, receipt_handle: str) -> None:
        """Remove a message from the queue by its *receipt_handle*."""
        async with self._lock:
            self._messages = [m for m in self._messages if m.receipt_handle != receipt_handle]

    # ------------------------------------------------------------------
    # Helpers (internal, called under lock)
    # ------------------------------------------------------------------

    def _collect_visible(self, max_messages: int) -> list[SqsMessage]:
        """Return up to *max_messages* visible messages, updating state.

        For FIFO queues, messages in a group are blocked when the head
        of the group is already in flight from a *previous* receive call.
        Within a single batch, multiple messages from the same group are
        returned in order.
        """
        now = time.monotonic()
        blocked_groups = self._find_blocked_groups(now)
        result: list[SqsMessage] = []
        to_dlq: list[SqsMessage] = []

        for msg in self._messages:
            if len(result) >= max_messages:
                break
            if not self._is_eligible(msg, now, blocked_groups):
                continue
            if self._should_route_to_dlq(msg):
                to_dlq.append(msg)
                continue
            self._mark_received(msg, now)
            result.append(msg)

        for msg in to_dlq:
            self._route_to_dlq(msg)

        return result

    def _find_blocked_groups(self, now: float) -> set[str]:
        """Return FIFO groups that have an in-flight message."""
        groups: set[str] = set()
        if self.is_fifo:
            for msg in self._messages:
                if msg.message_group_id and msg.visibility_timeout_until > now:
                    groups.add(msg.message_group_id)
        return groups

    def _is_eligible(self, msg: SqsMessage, now: float, blocked_groups: set[str]) -> bool:
        """Return *True* if *msg* can be received right now."""
        if msg.visibility_timeout_until > now:
            return False
        if self.is_fifo and msg.message_group_id in blocked_groups:
            return False
        return True

    def _mark_received(self, msg: SqsMessage, now: float) -> None:
        """Update *msg* state to reflect that it has been received."""
        msg.receive_count += 1
        msg.attributes["ApproximateReceiveCount"] = str(msg.receive_count)
        msg.receipt_handle = str(uuid.uuid4())
        msg.visibility_timeout_until = now + self.visibility_timeout

    def _should_route_to_dlq(self, msg: SqsMessage) -> bool:
        """Check whether *msg* should be moved to the dead-letter queue."""
        return (
            self.dead_letter_queue is not None
            and self.max_receive_count > 0
            and msg.receive_count >= self.max_receive_count
        )

    def _route_to_dlq(self, msg: SqsMessage) -> None:
        """Move *msg* to the dead-letter queue (must be called under lock)."""
        self._messages.remove(msg)
        if self.dead_letter_queue is not None:
            # Reset visibility so DLQ consumers can receive it immediately
            msg.visibility_timeout_until = 0.0
            msg.receipt_handle = None
            self.dead_letter_queue.messages.append(msg)

    def _resolve_dedup_id(self, body: str, explicit_id: str | None) -> str | None:
        """Return the deduplication ID if FIFO dedup is applicable."""
        if not self.is_fifo:
            return None
        if explicit_id is not None:
            return explicit_id
        if self.content_based_dedup:
            return hashlib.sha256(body.encode()).hexdigest()
        return None

    def _is_duplicate(self, dedup_id: str) -> bool:
        """Return *True* if *dedup_id* is within its 5-minute window."""
        expiry = self._dedup_cache.get(dedup_id)
        if expiry is None:
            return False
        return time.monotonic() < expiry

    def _find_dedup_message_id(self, dedup_id: str) -> str:
        """Find the message_id for a duplicate dedup_id."""
        for msg in self._messages:
            if msg.message_dedup_id == dedup_id:
                return msg.message_id
        return str(uuid.uuid4())  # fallback

    def _purge_dedup_cache(self) -> None:
        """Remove expired entries from the deduplication cache."""
        now = time.monotonic()
        expired = [k for k, v in self._dedup_cache.items() if v <= now]
        for k in expired:
            del self._dedup_cache[k]

    @staticmethod
    def md5_of_body(body: str) -> str:
        """Return the hex MD5 digest of *body*."""
        return hashlib.md5(body.encode()).hexdigest()
