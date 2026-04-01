"""Direct HTTP helpers for the /_ldk/chaos/{service} management endpoints."""

from __future__ import annotations

from typing import Any

import httpx


def set_chaos(mgmt_port: int, service: str, error_rate: float, latency_ms: int) -> None:
    """Enable chaos for *service* by calling PUT /_ldk/chaos/{service}."""
    httpx.put(
        f"http://127.0.0.1:{mgmt_port}/_ldk/chaos/{service}",
        json={
            "error_rate": error_rate,
            "latency_min_ms": latency_ms,
            "latency_max_ms": latency_ms,
        },
        timeout=5.0,
    )


def reset_chaos(mgmt_port: int, service: str) -> None:
    """Disable and reset chaos for *service* by calling DELETE /_ldk/chaos/{service}."""
    httpx.delete(
        f"http://127.0.0.1:{mgmt_port}/_ldk/chaos/{service}",
        timeout=5.0,
    )


def get_chaos_status(mgmt_port: int, service: str) -> dict[str, Any]:
    """Return the chaos config for *service* by calling GET /_ldk/chaos/{service}."""
    resp = httpx.get(
        f"http://127.0.0.1:{mgmt_port}/_ldk/chaos/{service}",
        timeout=5.0,
    )
    resp.raise_for_status()
    return resp.json()
