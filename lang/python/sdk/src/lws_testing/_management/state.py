"""Direct HTTP helpers for the /_ldk/state management endpoints."""

from __future__ import annotations

import httpx


def inject_state(
    mgmt_port: int, service: str, resource_type: str, resource_id: str, state: str
) -> None:
    """Inject a resource state via PUT /_ldk/state/{service}/{resource_type}/{resource_id}."""
    httpx.put(
        f"http://127.0.0.1:{mgmt_port}/_ldk/state/{service}/{resource_type}/{resource_id}",
        json={"state": state},
        timeout=5.0,
    )


def clear_injected_state(
    mgmt_port: int, service: str, resource_type: str, resource_id: str
) -> None:
    """Clear an injected resource state via DELETE."""
    httpx.delete(
        f"http://127.0.0.1:{mgmt_port}/_ldk/state/{service}/{resource_type}/{resource_id}",
        timeout=5.0,
    )


def get_injected_state(
    mgmt_port: int, service: str, resource_type: str, resource_id: str
) -> str | None:
    """Return the injected state for a resource, or None if not set."""
    resp = httpx.get(
        f"http://127.0.0.1:{mgmt_port}/_ldk/state/{service}/{resource_type}/{resource_id}",
        timeout=5.0,
    )
    if resp.status_code == 404:
        return None
    return resp.json().get("state")
