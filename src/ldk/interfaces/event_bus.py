"""IEventBus interface for EventBridge-like event routing."""

from abc import abstractmethod

from ldk.interfaces.provider import Provider


class IEventBus(Provider):
    """Abstract interface for event bus providers (EventBridge-like).

    Implementations route events to registered targets based on
    matching rules.
    """

    @abstractmethod
    async def put_events(self, entries: list[dict]) -> list[dict]:
        """Publish one or more events to the event bus.

        Each entry should contain at minimum: Source, DetailType, and Detail.
        Returns a list of result entries indicating success or failure for each.
        """
        ...
