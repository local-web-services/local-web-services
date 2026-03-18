"""Fluent builder for configuring resource lifecycle simulation."""

from __future__ import annotations

import httpx


class LifecycleBuilder:
    """Fluent builder for AWS service lifecycle simulation configuration.

    Usage::

        session.lifecycle("dynamodb").create_dwell_ms(500).delete_dwell_ms(200).apply()
    """

    def __init__(self, service: str, mgmt_port: int) -> None:
        self._service = service
        self._mgmt_port = mgmt_port
        self._config: dict = {"enabled": True}

    def create_dwell_ms(self, ms: int) -> LifecycleBuilder:
        """Set the time resources spend in CREATING state before becoming ACTIVE."""
        self._config["create_dwell_ms"] = int(ms)
        return self

    def delete_dwell_ms(self, ms: int) -> LifecycleBuilder:
        """Set the time resources spend in DELETING state before removal."""
        self._config["delete_dwell_ms"] = int(ms)
        return self

    def apply(self) -> None:
        """Push the lifecycle configuration to the management API."""
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/lifecycle",
            json={self._service: self._config},
            timeout=5.0,
        )

    def clear(self) -> None:
        """Disable lifecycle simulation for this service."""
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/lifecycle",
            json={self._service: {"enabled": False, "create_dwell_ms": 0, "delete_dwell_ms": 0}},
            timeout=5.0,
        )
