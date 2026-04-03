"""Direct HTTP helpers for the /_ldk/state management endpoints."""

from __future__ import annotations

from urllib.parse import quote

import httpx


class InjectStateNotTracked(Exception):
    """Raised when inject_state returns 404 because the resource is not in the tracker."""


def _state_url(mgmt_port: int, service: str, resource_type: str, resource_id: str) -> str:
    encoded = quote(resource_id, safe="/")
    return f"http://127.0.0.1:{mgmt_port}/_ldk/state/{service}/{resource_type}/{encoded}"


def inject_state(
    mgmt_port: int, service: str, resource_type: str, resource_id: str, state: str
) -> None:
    """Inject a resource state via PUT /_ldk/state/{service}/{resource_type}/{resource_id}."""
    resp = httpx.put(
        _state_url(mgmt_port, service, resource_type, resource_id),
        json={"state": state},
        timeout=5.0,
    )
    if resp.status_code == 404 and "is not tracked" in resp.text:
        raise InjectStateNotTracked(resp.text)
    if resp.status_code != 200:
        raise RuntimeError(f"inject_state failed ({resp.status_code}): {resp.text}")


def clear_injected_state(
    mgmt_port: int, service: str, resource_type: str, resource_id: str
) -> None:
    """Clear an injected resource state via DELETE."""
    httpx.delete(
        _state_url(mgmt_port, service, resource_type, resource_id),
        timeout=5.0,
    )


def get_injected_state(
    mgmt_port: int, service: str, resource_type: str, resource_id: str
) -> str | None:
    """Return the injected state for a resource, or None if not set."""
    resp = httpx.get(
        _state_url(mgmt_port, service, resource_type, resource_id),
        timeout=5.0,
    )
    if resp.status_code == 404:
        return None
    return resp.json().get("state")
