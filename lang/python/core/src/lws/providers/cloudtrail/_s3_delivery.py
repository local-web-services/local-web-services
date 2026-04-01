"""Background S3 delivery task for CloudTrail log files."""

from __future__ import annotations

import asyncio
import contextlib
import datetime
import gzip
import json
import logging
import random
import string
from typing import TYPE_CHECKING, Any

if TYPE_CHECKING:
    from lws.providers.cloudtrail._cloudtrail_state import EventBuffer, TrailConfig
    from lws.providers.s3.provider import S3Provider

_logger = logging.getLogger(__name__)

_FLUSH_INTERVAL_SECONDS = 300  # 5 minutes
_FAKE_ACCOUNT = "000000000000"
_FAKE_REGION = "us-east-1"


def _s3_key(trail: TrailConfig, now: datetime.datetime) -> str:
    rand = "".join(random.choices(string.ascii_lowercase + string.digits, k=8))  # noqa: S311
    date_path = now.strftime("%Y/%m/%d")
    timestamp = now.strftime("%Y%m%dT%H%M%SZ")
    prefix = f"{trail.s3_key_prefix}/" if trail.s3_key_prefix else ""
    return (
        f"{prefix}AWSLogs/{_FAKE_ACCOUNT}/CloudTrail/{_FAKE_REGION}/"
        f"{date_path}/{_FAKE_ACCOUNT}_CloudTrail_{_FAKE_REGION}_{timestamp}_{rand}.json.gz"
    )


def _compress(events: list[dict[str, Any]]) -> bytes:
    payload = json.dumps({"Records": events}).encode("utf-8")
    return gzip.compress(payload)


async def flush_to_s3(
    trail: TrailConfig,
    events: list[dict[str, Any]],
    s3_provider: S3Provider,
) -> None:
    """Write *events* as a gzip log file under the trail's S3 bucket."""
    if not events:
        return
    now = datetime.datetime.now(datetime.UTC)
    key = _s3_key(trail, now)
    body = _compress(events)
    try:
        await s3_provider.put_object(trail.s3_bucket, key, body, content_type="application/x-gzip")
        trail.latest_delivery_time = now.strftime("%Y-%m-%dT%H:%M:%SZ")
        trail.latest_delivery_error = None
        _logger.debug(
            "CloudTrail: flushed %d events to s3://%s/%s", len(events), trail.s3_bucket, key
        )
    except Exception as exc:  # pylint: disable=broad-except
        trail.latest_delivery_error = str(exc)
        _logger.warning("CloudTrail: S3 delivery failed for trail %s: %s", trail.name, exc)


class S3DeliveryTask:
    """Periodic background task that flushes CloudTrail events to S3."""

    def __init__(
        self,
        get_logging_trails: Any,
        buffer: EventBuffer,
        get_s3_provider: Any,
        high_water: int = 1_000,
        interval: float = _FLUSH_INTERVAL_SECONDS,
    ) -> None:
        self._get_logging_trails = get_logging_trails
        self._buffer = buffer
        self._get_s3_provider = get_s3_provider
        self._high_water = high_water
        self._interval = interval
        self._task: asyncio.Task | None = None  # type: ignore[type-arg]

    def start(self) -> None:
        """Start the periodic flush background task."""
        self._task = asyncio.create_task(self._run())

    async def stop(self) -> None:
        """Cancel the background task and wait for it to finish."""
        if self._task is None:
            return
        self._task.cancel()
        with contextlib.suppress(asyncio.CancelledError):
            await self._task
        self._task = None

    async def flush_now(self) -> None:
        """Trigger an immediate flush (e.g., on shutdown)."""
        await self._do_flush()

    async def _run(self) -> None:
        while True:
            try:
                await asyncio.sleep(self._interval)
                await self._do_flush()
            except asyncio.CancelledError:
                break
            except Exception as exc:  # pylint: disable=broad-except
                _logger.warning("CloudTrail: delivery loop error: %s", exc)

    async def _do_flush(self) -> None:
        s3 = self._get_s3_provider()
        if s3 is None:
            return
        trails = self._get_logging_trails()
        if not trails:
            return
        events = self._buffer.drain()
        if not events:
            return
        for trail in trails:
            await flush_to_s3(trail, events, s3)
