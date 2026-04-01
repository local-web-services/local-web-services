"""CloudTrail in-memory state: trail configs and event ring buffer."""

from __future__ import annotations

import collections
import threading
import uuid
from dataclasses import dataclass
from enum import StrEnum
from typing import Any

_MAX_BUFFER = 10_000
_FLUSH_HIGH_WATER = 1_000
_MAX_TRAILS = 5

_FAKE_ACCOUNT = "000000000000"
_FAKE_REGION = "us-east-1"


class TrailState(StrEnum):
    CREATED = "CREATED"
    DELETED = "DELETED"


@dataclass
class TrailConfig:
    """Configuration and runtime state for a single CloudTrail trail."""

    name: str
    s3_bucket: str
    s3_key_prefix: str = ""
    eventbridge_bus_arn: str = ""
    logging: bool = False
    state: TrailState = TrailState.CREATED
    latest_delivery_time: str | None = None
    latest_delivery_error: str | None = None

    @property
    def arn(self) -> str:
        """Return the full ARN for this trail."""
        return f"arn:aws:cloudtrail:{_FAKE_REGION}:{_FAKE_ACCOUNT}:trail/{self.name}"

    def to_api_dict(self) -> dict[str, Any]:
        """Serialize trail config to the CloudTrail API response shape."""
        return {
            "TrailARN": self.arn,
            "Name": self.name,
            "S3BucketName": self.s3_bucket,
            "S3KeyPrefix": self.s3_key_prefix,
            "HasCustomEventSelectors": True,
            "HasInsightSelectors": False,
            "IsMultiRegionTrail": False,
            "IsOrganizationTrail": False,
            "HomeRegion": _FAKE_REGION,
            "LogFileValidationEnabled": False,
            "IncludeGlobalServiceEvents": True,
        }

    def to_status_dict(self) -> dict[str, Any]:
        """Serialize trail logging status to the GetTrailStatus response shape."""
        d: dict[str, Any] = {
            "TrailARN": self.arn,
            "IsLogging": self.logging,
        }
        if self.latest_delivery_time:
            d["LatestDeliveryTime"] = self.latest_delivery_time
        if self.latest_delivery_error:
            d["LatestDeliveryError"] = self.latest_delivery_error
        return d


class EventBuffer:
    """Thread-safe in-memory ring buffer for CloudTrail events."""

    def __init__(self, maxlen: int = _MAX_BUFFER) -> None:
        self._lock = threading.Lock()
        self._buffer: collections.deque[dict[str, Any]] = collections.deque(maxlen=maxlen)

    def append(self, event: dict[str, Any]) -> None:
        """Append an event to the ring buffer."""
        with self._lock:
            self._buffer.append(event)

    def snapshot(self) -> list[dict[str, Any]]:
        """Return a copy of all buffered events, newest first."""
        with self._lock:
            return list(reversed(self._buffer))

    def drain(self) -> list[dict[str, Any]]:
        """Remove and return all buffered events, oldest first (for S3 delivery)."""
        with self._lock:
            events = list(self._buffer)
            self._buffer.clear()
            return events

    def __len__(self) -> int:
        """Return the number of buffered events."""
        with self._lock:
            return len(self._buffer)


def _new_trail_id() -> str:
    return str(uuid.uuid4())
