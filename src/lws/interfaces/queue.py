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

    @abstractmethod
    async def receive_messages(
        self,
        queue_name: str,
        max_messages: int = 1,
        wait_time_seconds: int = 0,
    ) -> list[dict]:
        """Receive messages from the queue."""

    @abstractmethod
    async def delete_message(self, queue_name: str, receipt_handle: str) -> None:
        """Delete a message from the queue using its receipt handle."""

    @abstractmethod
    async def create_queue(self, queue_name: str, attributes: dict | None = None) -> str:
        """Create a queue. Returns the queue URL."""

    @abstractmethod
    async def delete_queue(self, queue_name: str) -> None:
        """Delete a queue."""

    @abstractmethod
    async def get_queue_attributes(self, queue_name: str) -> dict:
        """Return queue attributes dict."""

    @abstractmethod
    async def list_queues(self) -> list[str]:
        """Return list of queue names."""
