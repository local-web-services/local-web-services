"""AWS CloudTrail in-memory state classes."""

from __future__ import annotations

import time
import uuid

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


def _trail_arn(trail_name: str) -> str:
    """Return the ARN for a CloudTrail trail."""
    return f"arn:aws:cloudtrail:{_REGION}:{_ACCOUNT_ID}:trail/{trail_name}"


class _CloudTrailState:
    """In-memory store for AWS CloudTrail resources."""

    def __init__(self) -> None:
        """Initialise empty state."""
        self._trails: dict[str, dict] = {}
        self._logging: dict[str, bool] = {}
        self._event_selectors: dict[str, list] = {}
        self._events: list[dict] = []

    @property
    def trails(self) -> dict[str, dict]:
        """Return the trails store keyed by trail name."""
        return self._trails

    @property
    def events(self) -> list[dict]:
        """Return the list of recorded CloudTrail events."""
        return self._events

    def logging_enabled(self, trail_name: str) -> bool:
        """Return whether logging is enabled for a trail."""
        return self._logging.get(trail_name, False)

    def set_logging(self, trail_name: str, enabled: bool) -> None:
        """Set the logging state for a trail."""
        self._logging[trail_name] = enabled

    def get_event_selectors(self, trail_name: str) -> list:
        """Return event selectors for a trail."""
        return self._event_selectors.get(trail_name, [])

    def set_event_selectors(self, trail_name: str, selectors: list) -> None:
        """Store event selectors for a trail."""
        self._event_selectors[trail_name] = selectors

    def record_event(self, action: str) -> None:
        """Record a CloudTrail event for a self-logged API call."""
        event: dict = {
            "EventId": str(uuid.uuid4()),
            "EventName": action,
            "EventTime": time.time(),
            "Username": "lws-local",
            "Resources": [],
        }
        self._events.append(event)

    def reset(self) -> None:
        """Reset all state to empty, as if the service was just started."""
        self._trails = {}
        self._logging = {}
        self._event_selectors = {}
        self._events = []
