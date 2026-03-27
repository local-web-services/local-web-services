"""HTTP client wrapping the /_ldk/fake management API for fake server operations."""

from __future__ import annotations

from typing import Any

import httpx


class FakeServerClient:
    """Client for the LWS fake server management API (/_ldk/fake).

    Returned by ``lws_session.client("fake")``.  Provides methods to create,
    manage, and make requests to in-process fake HTTP servers.

    Usage::

        fake = session.client("fake")
        fake.create_server("my-server")
        fake.add_route("my-server", "GET", "/health", status=200, body={"ok": True})
    """

    def __init__(self, mgmt_port: int) -> None:
        self._mgmt_port = mgmt_port
        self._base = f"http://127.0.0.1:{mgmt_port}/_ldk/fake"

    def list_servers(self) -> list[dict[str, Any]]:
        """Return info about all running fake servers."""
        resp = httpx.get(self._base, timeout=5.0)
        resp.raise_for_status()
        return resp.json()["servers"]

    def create_server(
        self, name: str, protocol: str = "rest", description: str = ""
    ) -> dict[str, Any]:
        """Create a new fake server. Raises if a server with the same name already exists."""
        resp = httpx.post(
            self._base,
            json={"name": name, "protocol": protocol, "description": description},
            timeout=5.0,
        )
        if resp.status_code == 409:
            raise ValueError(resp.json().get("error", f"Fake server '{name}' already exists"))
        resp.raise_for_status()
        return resp.json()

    def get_status(self, name: str) -> dict[str, Any]:
        """Return info about a specific fake server."""
        resp = httpx.get(f"{self._base}/{name}", timeout=5.0)
        if resp.status_code == 404:
            raise KeyError(f"Fake server '{name}' not found")
        resp.raise_for_status()
        return resp.json()

    def delete_server(self, name: str) -> None:
        """Delete a fake server."""
        resp = httpx.delete(f"{self._base}/{name}", timeout=5.0)
        if resp.status_code == 404:
            raise KeyError(f"Fake server '{name}' not found")
        resp.raise_for_status()

    def add_route(
        self,
        server_name: str,
        method: str,
        path: str,
        status: int = 200,
        body: Any = None,
        headers: dict[str, str] | None = None,
    ) -> dict[str, Any]:
        """Add a route to a fake server."""
        payload: dict[str, Any] = {"method": method, "path": path, "status": status}
        if body is not None:
            payload["body"] = body
        if headers:
            payload["headers"] = headers
        resp = httpx.post(f"{self._base}/{server_name}/routes", json=payload, timeout=5.0)
        if resp.status_code == 404:
            raise KeyError(f"Fake server '{server_name}' not found")
        if resp.status_code == 409:
            raise ValueError(resp.json().get("error", f"Route {method} {path} already exists"))
        resp.raise_for_status()
        return resp.json()

    def remove_route(self, server_name: str, method: str, path: str) -> None:
        """Remove a route from a fake server."""
        resp = httpx.delete(
            f"{self._base}/{server_name}/routes",
            json={"method": method, "path": path},
            timeout=5.0,
        )
        if resp.status_code == 404:
            raise KeyError(resp.json().get("error", "Route or server not found"))
        resp.raise_for_status()

    def set_chaos(
        self,
        server_name: str,
        enabled: bool,
        error_rate: float = 0.0,
        latency_min_ms: int = 0,
        latency_max_ms: int = 0,
    ) -> dict[str, Any]:
        """Configure chaos on a fake server."""
        resp = httpx.post(
            f"{self._base}/{server_name}/chaos",
            json={
                "enabled": enabled,
                "error_rate": error_rate,
                "latency_min_ms": latency_min_ms,
                "latency_max_ms": latency_max_ms,
            },
            timeout=5.0,
        )
        if resp.status_code == 404:
            raise KeyError(f"Fake server '{server_name}' not found")
        resp.raise_for_status()
        return resp.json()

    def make_request(
        self,
        server_name: str,
        method: str,
        path: str,
        body: Any = None,
        headers: dict[str, str] | None = None,
    ) -> dict[str, Any]:
        """Make an HTTP request to a running fake server via the management proxy.

        Returns a dict with ``status``, ``headers``, and ``body`` keys.
        """
        server_info = self.get_status(server_name)
        port = server_info["port"]
        url = f"http://127.0.0.1:{port}{path}"
        resp = httpx.request(
            method=method.upper(),
            url=url,
            json=body if body is not None else None,
            headers=headers or {},
            timeout=5.0,
        )
        return {
            "status": resp.status_code,
            "headers": dict(resp.headers),
            "body": resp.json() if resp.content else None,
        }
