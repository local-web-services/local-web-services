"""Fluent builder for configuring AWS service capacity."""

from __future__ import annotations

import httpx


class CapacityBuilder:
    """Fluent builder for AWS service capacity configuration.

    Usage::

        session.capacity("stepfunctions").exhaust().apply()
        session.capacity("lambda").exhaust().apply()
    """

    def __init__(self, service: str, mgmt_port: int) -> None:
        self._service = service
        self._mgmt_port = mgmt_port
        self._config: dict = {}

    def exhaust(self) -> CapacityBuilder:
        """Set slot count to zero (no capacity available)."""
        self._config["slots"] = 0
        return self

    def slots(self, n: int) -> CapacityBuilder:
        """Set slot count to a specific value."""
        self._config["slots"] = int(n)
        return self

    def unlimited(self) -> CapacityBuilder:
        """Remove slot limit (restore unlimited capacity)."""
        self._config["slots"] = None
        return self

    def apply(self) -> None:
        """Push the capacity configuration to the management API."""
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/capacity",
            json={self._service: self._config},
            timeout=5.0,
        )

    def is_exhausted(self) -> bool:
        """Return True if the service currently has zero capacity."""
        resp = httpx.get(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/capacity",
            timeout=5.0,
        )
        data = resp.json()
        capacity = data.get("capacity", data)
        svc = capacity.get(self._service, {})
        slots = svc.get("slots")
        return slots is not None and slots == 0

    def clear(self) -> None:
        """Restore unlimited capacity for this service."""
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/capacity",
            json={self._service: {"slots": None}},
            timeout=5.0,
        )
