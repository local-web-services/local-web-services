"""IQueue interface for SQS-like message queue operations."""

from abc import abstractmethod

from lws.interfaces.provider import Provider


class IQueue(Provider):
    """Abstract interface for queue providers (SQS-like).

    Implementations provide message send, receive, and delete operations
    against a local or remote queue.
    """

    @abstractmethod
    async def send_message(
        self,
        queue_name: str,
        message_body: str,
        message_attributes: dict | None = None,
        delay_seconds: int = 0,
    ) -> str:
        """Send a message to the queue. Returns the message ID."""
        ...

    @abstractmethod
    async def receive_messages(
        self,
        queue_name: str,
        max_messages: int = 1,
        wait_time_seconds: int = 0,
    ) -> list[dict]:
        """Receive messages from the queue."""
        ...

    @abstractmethod
    async def delete_message(self, queue_name: str, receipt_handle: str) -> None:
        """Delete a message from the queue using its receipt handle."""
        ...
