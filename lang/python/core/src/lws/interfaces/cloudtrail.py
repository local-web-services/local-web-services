"""CloudTrail provider interface."""

from __future__ import annotations

from abc import ABC, abstractmethod
from typing import Any


class ICloudTrail(ABC):
    """Abstract interface for CloudTrail event recording and trail management."""

    @abstractmethod
    def record_event(self, event: dict[str, Any]) -> None:
        """Buffer a CloudTrail event. Thread-safe, non-blocking."""

    @abstractmethod
    async def lookup_events(
        self,
        lookup_attributes: list[dict[str, str]] | None = None,
        start_time: str | None = None,
        end_time: str | None = None,
        max_results: int = 50,
        next_token: str | None = None,
    ) -> dict[str, Any]:
        """Query buffered events with optional filters. Returns AWS response shape."""
