"""Health check polling for ECS services.

Implements an asynchronous polling loop that periodically checks the health
of a running service by issuing HTTP GET requests to a configured endpoint.
Supports start-period grace windows, retry thresholds, and configurable
intervals.
"""

from __future__ import annotations

import asyncio
import logging
from dataclasses import dataclass
from enum import Enum

logger = logging.getLogger(__name__)


class HealthStatus(Enum):
    """Possible health states for a service."""

    UNKNOWN = "unknown"
    HEALTHY = "healthy"
    UNHEALTHY = "unhealthy"


@dataclass
class HealthCheckConfig:
    """Configuration for health-check polling.

    Attributes:
        endpoint: Full URL to GET (e.g. ``http://localhost:8080/health``).
        interval: Seconds between successive checks.
        timeout: Seconds to wait for each individual HTTP request.
        retries: Number of consecutive failures before marking unhealthy.
        start_period: Grace period (seconds) after start during which
            failures do not count toward the *retries* threshold.
    """

    endpoint: str
    interval: float = 30.0
    timeout: float = 5.0
    retries: int = 3
    start_period: float = 0.0


async def _http_get_ok(url: str, timeout: float) -> bool:
    """Issue a GET and return ``True`` only when status is 200.

    Uses a raw :class:`asyncio.open_connection` approach so that no
    third-party HTTP library is required at import time.
    """
    try:
        from urllib.parse import urlparse  # pylint: disable=import-outside-toplevel

        parsed = urlparse(url)
        host = parsed.hostname or "localhost"
        port = parsed.port or 80
        path = parsed.path or "/"

        reader, writer = await asyncio.wait_for(
            asyncio.open_connection(host, port),
            timeout=timeout,
        )
        request_line = f"GET {path} HTTP/1.1\r\nHost: {host}\r\nConnection: close\r\n\r\n"
        writer.write(request_line.encode())
        await writer.drain()
        status_line = await asyncio.wait_for(reader.readline(), timeout=timeout)
        writer.close()
        parts = status_line.decode().split()
        return len(parts) >= 2 and parts[1] == "200"
    except Exception:
        return False


class HealthChecker:
    """Asynchronous health-check poller for a single service.

    Call :meth:`start` to begin polling in the background and :meth:`stop`
    to cancel the loop.
    """

    def __init__(self, config: HealthCheckConfig) -> None:
        self._config = config
        self._status = HealthStatus.UNKNOWN
        self._consecutive_failures = 0
        self._task: asyncio.Task[None] | None = None

    @property
    def status(self) -> HealthStatus:
        """Return the current health status."""
        return self._status

    # ------------------------------------------------------------------
    # Lifecycle
    # ------------------------------------------------------------------

    def start(self) -> None:
        """Start the background polling loop."""
        if self._task is not None:
            return
        self._status = HealthStatus.UNKNOWN
        self._consecutive_failures = 0
        self._task = asyncio.create_task(self._poll_loop())

    async def stop(self) -> None:
        """Cancel the polling loop and reset status."""
        if self._task is not None:
            self._task.cancel()
            try:
                await self._task
            except asyncio.CancelledError:
                pass
            self._task = None
        self._status = HealthStatus.UNKNOWN

    # ------------------------------------------------------------------
    # Polling loop
    # ------------------------------------------------------------------

    async def _poll_loop(self) -> None:
        """Repeatedly check health, respecting start-period and retries."""
        if self._config.start_period > 0:
            await asyncio.sleep(self._config.start_period)

        while True:
            ok = await _http_get_ok(self._config.endpoint, self._config.timeout)
            self._apply_result(ok)
            await asyncio.sleep(self._config.interval)

    def _apply_result(self, ok: bool) -> None:
        """Update status based on a single check result."""
        if ok:
            self._consecutive_failures = 0
            self._status = HealthStatus.HEALTHY
            logger.debug("Health check passed for %s", self._config.endpoint)
        else:
            self._consecutive_failures += 1
            if self._consecutive_failures >= self._config.retries:
                self._status = HealthStatus.UNHEALTHY
                logger.warning(
                    "Health check failed %d times for %s",
                    self._consecutive_failures,
                    self._config.endpoint,
                )
