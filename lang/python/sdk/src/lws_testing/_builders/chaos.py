"""Fluent builder for configuring chaos engineering rules."""

from __future__ import annotations

import httpx


class ChaosBuilder:
    """Fluent builder for AWS service chaos configuration.

    Usage::

        session.chaos("dynamodb").error_rate(0.3).latency(min_ms=50, max_ms=200).apply()
    """

    def __init__(self, service: str, mgmt_port: int) -> None:
        self._service = service
        self._mgmt_port = mgmt_port
        self._config: dict = {"enabled": True}

    def error_rate(self, rate: float) -> ChaosBuilder:
        """Set the fraction of requests that return an error (0.0–1.0)."""
        self._config["error_rate"] = float(rate)
        return self

    def latency(self, min_ms: int = 0, max_ms: int = 0) -> ChaosBuilder:
        """Inject artificial latency into responses."""
        self._config["latency_min_ms"] = min_ms
        self._config["latency_max_ms"] = max_ms
        return self

    def connection_reset_rate(self, rate: float) -> ChaosBuilder:
        """Set the fraction of requests that receive a connection reset (0.0–1.0)."""
        self._config["connection_reset_rate"] = float(rate)
        return self

    def timeout_rate(self, rate: float) -> ChaosBuilder:
        """Set the fraction of requests that time out (0.0–1.0)."""
        self._config["timeout_rate"] = float(rate)
        return self

    def apply(self) -> None:
        """Push the chaos configuration to the management API."""
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/chaos",
            json={self._service: self._config},
            timeout=5.0,
        )

    def clear(self) -> None:
        """Disable chaos for this service."""
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/chaos",
            json={self._service: {"enabled": False, "error_rate": 0.0}},
            timeout=5.0,
        )
