"""SQS helper for seeding and asserting queue state."""

from __future__ import annotations

from typing import Any


class SQSHelper:
    """Convenience wrapper for a single SQS queue.

    Usage::

        queue = session.sqs("OrderQueue")
        queue.send({"orderId": "42"})
        messages = queue.receive()
        assert len(messages) == 1
    """

    def __init__(self, queue_name: str, client: Any, port: int) -> None:
        self._queue_name = queue_name
        self._client = client
        self._queue_url = f"http://127.0.0.1:{port}/000000000000/{queue_name}"

    def send(self, body: str | dict[str, Any], **kwargs: Any) -> str:
        """Send a message to the queue; returns the message ID.

        *body* may be a plain string or a dict (which will be JSON-encoded).
        """
        import json

        if isinstance(body, dict):
            message_body = json.dumps(body)
        else:
            message_body = body
        response = self._client.send_message(
            QueueUrl=self._queue_url,
            MessageBody=message_body,
            **kwargs,
        )
        return response["MessageId"]

    def receive(
        self,
        max_messages: int = 10,
        wait_seconds: int = 0,
    ) -> list[dict[str, Any]]:
        """Receive up to *max_messages* messages from the queue."""
        response = self._client.receive_message(
            QueueUrl=self._queue_url,
            MaxNumberOfMessages=min(max_messages, 10),
            WaitTimeSeconds=wait_seconds,
        )
        return response.get("Messages", [])

    def purge(self) -> None:
        """Delete all messages from the queue."""
        self._client.purge_queue(QueueUrl=self._queue_url)

    def assert_message_count(self, expected_count: int) -> None:
        """Assert the approximate number of messages in the queue."""
        response = self._client.get_queue_attributes(
            QueueUrl=self._queue_url,
            AttributeNames=["ApproximateNumberOfMessages"],
        )
        actual_count = int(response["Attributes"].get("ApproximateNumberOfMessages", "0"))
        assert actual_count == expected_count, (
            f"Expected {expected_count} message(s) in queue {self._queue_name!r}, "
            f"but found approximately {actual_count}."
        )

    @property
    def url(self) -> str:
        """Return the queue URL."""
        return self._queue_url
