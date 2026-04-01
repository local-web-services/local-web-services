"""CloudTrail provider: trail lifecycle, event buffering, and delivery."""

from __future__ import annotations

import base64
import json
import logging
from typing import TYPE_CHECKING, Any

from lws.interfaces.cloudtrail import ICloudTrail
from lws.interfaces.provider import Provider
from lws.providers.cloudtrail._cloudtrail_state import (
    _FLUSH_HIGH_WATER,
    _MAX_TRAILS,
    EventBuffer,
    TrailConfig,
    TrailState,
)
from lws.providers.cloudtrail._s3_delivery import S3DeliveryTask

if TYPE_CHECKING:
    from lws.providers.eventbridge.provider import EventBridgeProvider
    from lws.providers.s3.provider import S3Provider

_logger = logging.getLogger(__name__)


class CloudTrailProvider(Provider, ICloudTrail):
    """In-memory CloudTrail provider.

    Manages trail lifecycle and buffers captured events. A background
    ``S3DeliveryTask`` periodically flushes events to the LWS S3 emulator.
    """

    def __init__(self) -> None:
        self._trails: dict[str, TrailConfig] = {}
        self._buffer = EventBuffer()
        self._s3_provider: S3Provider | None = None
        self._eb_provider: EventBridgeProvider | None = None
        self._delivery: S3DeliveryTask | None = None
        self._running = False

    # ------------------------------------------------------------------
    # Provider lifecycle
    # ------------------------------------------------------------------

    @property
    def name(self) -> str:
        return "cloudtrail"

    async def start(self) -> None:
        self._delivery = S3DeliveryTask(
            get_logging_trails=self._logging_trails,
            buffer=self._buffer,
            get_s3_provider=lambda: self._s3_provider,
            high_water=_FLUSH_HIGH_WATER,
        )
        self._delivery.start()
        self._running = True

    async def stop(self) -> None:
        if self._delivery:
            if self._s3_provider:
                await self._delivery.flush_now()
            await self._delivery.stop()
        self._running = False

    async def health_check(self) -> bool:
        return self._running

    async def reset(self) -> None:
        """Clear all trails and buffered events."""
        self._trails.clear()
        self._buffer.drain()

    # ------------------------------------------------------------------
    # Dependency injection
    # ------------------------------------------------------------------

    def set_s3_provider(self, provider: S3Provider) -> None:
        """Wire an S3 provider for CloudTrail log delivery."""
        self._s3_provider = provider

    def set_eventbridge_provider(self, provider: EventBridgeProvider) -> None:
        """Wire an EventBridge provider for CloudTrail event forwarding."""
        self._eb_provider = provider

    # ------------------------------------------------------------------
    # ICloudTrail — event recording
    # ------------------------------------------------------------------

    def record_event(self, event: dict[str, Any]) -> None:
        """Buffer a CloudTrail event and forward to EventBridge if configured."""
        self._buffer.append(event)
        if len(self._buffer) >= _FLUSH_HIGH_WATER and self._delivery:
            import asyncio  # pylint: disable=import-outside-toplevel

            try:
                loop = asyncio.get_running_loop()
                loop.create_task(self._delivery.flush_now())
            except RuntimeError:
                pass
        self._forward_to_eventbridge(event)

    def _forward_to_eventbridge(self, event: dict[str, Any]) -> None:
        if self._eb_provider is None:
            return
        for trail in self._logging_trails():
            if not trail.eventbridge_bus_arn:
                continue
            bus_name = trail.eventbridge_bus_arn.split("/")[-1]
            try:
                import asyncio  # pylint: disable=import-outside-toplevel

                loop = asyncio.get_running_loop()
                loop.create_task(
                    self._eb_provider.put_events(
                        [
                            {
                                "Source": "aws.cloudtrail",
                                "DetailType": "AWS API Call via CloudTrail",
                                "Detail": json.dumps(event),
                                "EventBusName": bus_name,
                            }
                        ]
                    )
                )
            except (RuntimeError, AttributeError) as exc:
                _logger.warning(
                    "CloudTrail: EventBridge forward failed for bus %s: %s", bus_name, exc
                )

    # ------------------------------------------------------------------
    # ICloudTrail — lookup
    # ------------------------------------------------------------------

    async def lookup_events(
        self,
        lookup_attributes: list[dict[str, str]] | None = None,
        start_time: str | None = None,
        end_time: str | None = None,
        max_results: int = 50,
        next_token: str | None = None,
    ) -> dict[str, Any]:
        events = self._buffer.snapshot()
        events = _filter_by_time(events, start_time, end_time)
        events = _apply_lookup_attributes(events, lookup_attributes)
        page, token = _paginate(events, next_token, max_results)
        response: dict[str, Any] = {"Events": [_to_lookup_event(e) for e in page]}
        if token:
            response["NextToken"] = token
        return response

    # ------------------------------------------------------------------
    # Trail management
    # ------------------------------------------------------------------

    def create_trail(self, name: str, s3_bucket: str, s3_key_prefix: str = "") -> TrailConfig:
        """Create a new trail; raises ValueError on duplicate name or capacity exceeded."""
        if name in self._trails and self._trails[name].state != TrailState.DELETED:
            raise ValueError(f"TrailAlreadyExistsException: {name}")
        active = sum(1 for t in self._trails.values() if t.state != TrailState.DELETED)
        if active >= _MAX_TRAILS:
            raise ValueError("MaximumNumberOfTrailsExceededException")
        trail = TrailConfig(name=name, s3_bucket=s3_bucket, s3_key_prefix=s3_key_prefix)
        self._trails[name] = trail
        return trail

    def update_trail(
        self,
        name: str,
        s3_bucket: str | None = None,
        s3_key_prefix: str | None = None,
        eventbridge_bus_arn: str | None = None,
    ) -> TrailConfig:
        """Update mutable fields on an existing trail."""
        trail = self._get_trail(name)
        if s3_bucket is not None:
            trail.s3_bucket = s3_bucket
        if s3_key_prefix is not None:
            trail.s3_key_prefix = s3_key_prefix
        if eventbridge_bus_arn is not None:
            trail.eventbridge_bus_arn = eventbridge_bus_arn
        return trail

    def delete_trail(self, name: str) -> None:
        """Soft-delete a trail by marking it as DELETED."""
        trail = self._get_trail(name)
        trail.logging = False
        trail.state = TrailState.DELETED

    def get_trail(self, name: str) -> TrailConfig:
        """Return the trail config for *name*; raises KeyError if absent."""
        return self._get_trail(name)

    def list_trails(self) -> list[TrailConfig]:
        """Return all non-deleted trails."""
        return [t for t in self._trails.values() if t.state != TrailState.DELETED]

    def start_logging(self, name: str) -> None:
        """Enable logging for a trail."""
        trail = self._get_trail(name)
        trail.logging = True

    def stop_logging(self, name: str) -> None:
        """Disable logging for a trail."""
        trail = self._get_trail(name)
        trail.logging = False

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------

    def _get_trail(self, name: str) -> TrailConfig:
        trail = self._trails.get(name)
        if trail is None or trail.state == TrailState.DELETED:
            raise KeyError(f"TrailNotFoundException: {name}")
        return trail

    def _logging_trails(self) -> list[TrailConfig]:
        return [t for t in self._trails.values() if t.state != TrailState.DELETED and t.logging]


# ------------------------------------------------------------------
# LookupEvents helpers
# ------------------------------------------------------------------


def _to_iso(ts: Any) -> str:
    """Convert a Unix timestamp (int/float) or ISO string to an ISO datetime string."""
    import datetime  # pylint: disable=import-outside-toplevel

    if isinstance(ts, (int, float)):
        dt = datetime.datetime.fromtimestamp(ts, tz=datetime.UTC)
        return dt.strftime("%Y-%m-%dT%H:%M:%SZ")
    return str(ts)


def _filter_by_time(
    events: list[dict[str, Any]],
    start_time: Any | None,
    end_time: Any | None,
) -> list[dict[str, Any]]:
    if start_time:
        start_iso = _to_iso(start_time)
        events = [e for e in events if e.get("eventTime", "") >= start_iso]
    if end_time:
        end_iso = _to_iso(end_time)
        events = [e for e in events if e.get("eventTime", "") <= end_iso]
    return events


def _apply_lookup_attributes(
    events: list[dict[str, Any]],
    lookup_attributes: list[dict[str, str]] | None,
) -> list[dict[str, Any]]:
    for attr in lookup_attributes or []:
        k, v = attr.get("AttributeKey", ""), attr.get("AttributeValue", "")
        events = _apply_filter(events, k, v)
    return events


_EVENT_FIELD_MAP: dict[str, str] = {
    "EventName": "eventName",
    "EventSource": "eventSource",
    "EventId": "eventID",
}
_IDENTITY_FIELD_MAP: dict[str, str] = {
    "Username": "userName",
    "AccessKeyId": "accessKeyId",
}


def _filter_read_only(events: list[dict[str, Any]], value: str) -> list[dict[str, Any]]:
    read_only = value.lower() == "true"
    return [e for e in events if e.get("readOnly", False) == read_only]


def _filter_resource_type(events: list[dict[str, Any]], value: str) -> list[dict[str, Any]]:
    return [e for e in events if any(r.get("type") == value for r in e.get("resources", []))]


def _filter_resource_name(events: list[dict[str, Any]], value: str) -> list[dict[str, Any]]:
    return [
        e
        for e in events
        if any(
            r.get("ARN", "").endswith(value) or r.get("name") == value
            for r in e.get("resources", [])
        )
    ]


def _apply_filter(events: list[dict[str, Any]], key: str, value: str) -> list[dict[str, Any]]:
    if key in _EVENT_FIELD_MAP:
        return [e for e in events if e.get(_EVENT_FIELD_MAP[key]) == value]
    if key in _IDENTITY_FIELD_MAP:
        field = _IDENTITY_FIELD_MAP[key]
        return [e for e in events if e.get("userIdentity", {}).get(field) == value]
    if key == "ReadOnly":
        return _filter_read_only(events, value)
    if key == "ResourceType":
        return _filter_resource_type(events, value)
    if key == "ResourceName":
        return _filter_resource_name(events, value)
    return events


def _paginate(
    events: list[dict[str, Any]], next_token: str | None, max_results: int
) -> tuple[list[dict[str, Any]], str | None]:
    offset = 0
    if next_token:
        try:
            offset = int(base64.b64decode(next_token).decode())
        except Exception:  # pylint: disable=broad-except
            offset = 0
    page = events[offset : offset + max_results]
    next_offset = offset + max_results
    has_more = next_offset < len(events)
    token = base64.b64encode(str(next_offset).encode()).decode() if has_more else None
    return page, token


def _to_lookup_event(e: dict[str, Any]) -> dict[str, Any]:
    return {
        "EventId": e.get("eventID", ""),
        "EventName": e.get("eventName", ""),
        "EventTime": e.get("eventTime", ""),
        "EventSource": e.get("eventSource", ""),
        "Username": e.get("userIdentity", {}).get("userName", ""),
        "Resources": [
            {"ResourceType": r.get("type", ""), "ResourceName": r.get("ARN", r.get("name", ""))}
            for r in e.get("resources", [])
        ],
        "CloudTrailEvent": json.dumps(e),
    }
