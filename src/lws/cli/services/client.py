"""Shared client for the ``lws`` CLI.

Handles discovery via the ``GET /_ldk/resources`` management endpoint and
provides per-protocol HTTP helpers for calling provider wire protocols.
"""

from __future__ import annotations

import asyncio as _asyncio
import json
import sys
from typing import Any
from xml.etree import ElementTree

import httpx

_TRANSIENT_ERRORS = (httpx.ConnectError, httpx.ReadError, httpx.WriteError, httpx.PoolTimeout)
_MAX_RETRIES = 3
_RETRY_DELAY = 0.5


class DiscoveryError(Exception):
    """Raised when the ``/_ldk/resources`` endpoint is unreachable."""


class LwsClient:
    """Client that discovers local resources and makes wire-protocol calls."""

    def __init__(self, port: int = 3000) -> None:
        self._port = port
        self._base = f"http://localhost:{port}"
        self._metadata: dict[str, Any] | None = None

    async def discover(self) -> dict[str, Any]:
        """Fetch resource metadata from the running ``ldk dev`` instance."""
        if self._metadata is not None:
            return self._metadata
        try:
            async with httpx.AsyncClient() as client:
                resp = await client.get(f"{self._base}/_ldk/resources", timeout=5.0)
                resp.raise_for_status()
                self._metadata = resp.json()
                return self._metadata
        except Exception as exc:
            raise DiscoveryError(
                f"Cannot reach ldk dev on port {self._port}. Is it running?"
            ) from exc

    async def service_port(self, service: str) -> int:
        """Return the port for *service* (e.g. ``"sqs"``, ``"stepfunctions"``)."""
        meta = await self.discover()
        svc = meta.get("services", {}).get(service)
        if svc is None:
            raise DiscoveryError(f"Service '{service}' not found in running ldk dev")
        return int(svc["port"])

    async def service_resources(self, service: str) -> list[dict[str, Any]]:
        """Return the resource list for *service*."""
        meta = await self.discover()
        svc = meta.get("services", {}).get(service)
        if svc is None:
            return []
        return svc.get("resources", [])

    async def resolve_resource(self, service: str, name: str, key: str = "name") -> dict[str, Any]:
        """Find a resource by *name* within *service*."""
        resources = await self.service_resources(service)
        for r in resources:
            if r.get(key) == name:
                return r
        raise DiscoveryError(f"Resource '{name}' not found in service '{service}'")

    # ------------------------------------------------------------------
    # Wire protocol helpers
    # ------------------------------------------------------------------

    async def json_target_request(
        self,
        service: str,
        target: str,
        body: dict[str, Any] | None = None,
        content_type: str = "application/x-amz-json-1.0",
    ) -> dict[str, Any]:
        """Send a JSON request with ``X-Amz-Target`` header dispatch."""
        port = await self.service_port(service)
        headers = {
            "Content-Type": content_type,
            "X-Amz-Target": target,
        }
        for attempt in range(_MAX_RETRIES):
            try:
                async with httpx.AsyncClient() as client:
                    resp = await client.post(
                        f"http://localhost:{port}/",
                        headers=headers,
                        content=json.dumps(body or {}),
                        timeout=30.0,
                    )
                return resp.json()
            except _TRANSIENT_ERRORS:
                if attempt == _MAX_RETRIES - 1:
                    raise
                await _asyncio.sleep(_RETRY_DELAY)
        raise RuntimeError("unreachable")  # pragma: no cover

    async def form_request(self, service: str, params: dict[str, str]) -> str:
        """Send a form-encoded request and return the XML response body."""
        port = await self.service_port(service)
        for attempt in range(_MAX_RETRIES):
            try:
                async with httpx.AsyncClient() as client:
                    resp = await client.post(
                        f"http://localhost:{port}/",
                        data=params,
                        timeout=30.0,
                    )
                return resp.text
            except _TRANSIENT_ERRORS:
                if attempt == _MAX_RETRIES - 1:
                    raise
                await _asyncio.sleep(_RETRY_DELAY)
        raise RuntimeError("unreachable")  # pragma: no cover

    async def rest_request(
        self,
        service: str,
        method: str,
        path: str,
        *,
        body: bytes | None = None,
        params: dict[str, str] | None = None,
        headers: dict[str, str] | None = None,
    ) -> httpx.Response:
        """Send a REST-style request (method + path) and return the raw response."""
        port = await self.service_port(service)
        for attempt in range(_MAX_RETRIES):
            try:
                async with httpx.AsyncClient() as client:
                    resp = await client.request(
                        method,
                        f"http://localhost:{port}/{path.lstrip('/')}",
                        content=body,
                        params=params,
                        headers=headers,
                        timeout=30.0,
                    )
                return resp
            except _TRANSIENT_ERRORS:
                if attempt == _MAX_RETRIES - 1:
                    raise
                await _asyncio.sleep(_RETRY_DELAY)
        raise RuntimeError("unreachable")  # pragma: no cover


def parse_json_option(value: str, option_name: str) -> Any:
    """Parse a JSON CLI option, exiting with a friendly error on failure."""
    try:
        return json.loads(value)
    except json.JSONDecodeError as exc:
        exit_with_error(f"Invalid JSON in {option_name}: {exc}")
        return None  # unreachable; satisfies pylint R1710


async def json_request_output(port: int, service: str, target: str, body: dict[str, Any]) -> None:
    """Make a JSON-target request and print the result. Shared by tag helpers."""
    client = LwsClient(port=port)
    try:
        result = await client.json_target_request(service, target, body)
    except Exception as exc:
        exit_with_error(str(exc))
    output_json(result)


def build_chaos_body(
    error_rate: float | None = None,
    latency_min: int | None = None,
    latency_max: int | None = None,
    **extras: Any,
) -> dict[str, Any]:
    """Build a chaos config update body from optional CLI parameters."""
    body: dict[str, Any] = {}
    if error_rate is not None:
        body["error_rate"] = error_rate
    if latency_min is not None:
        body["latency_min_ms"] = latency_min
    if latency_max is not None:
        body["latency_max_ms"] = latency_max
    for key, val in extras.items():
        if val is not None:
            body[key] = val
    return body


def output_json(data: Any) -> None:
    """Print *data* as formatted JSON to stdout."""
    print(json.dumps(data, indent=2, default=str))


def exit_with_error(message: str) -> None:
    """Print an error message to stderr and exit."""
    print(json.dumps({"error": message}), file=sys.stderr)
    raise SystemExit(1)


async def ldk_get(port: int, path: str) -> None:
    """GET a management API endpoint and print the JSON response."""
    base = f"http://localhost:{port}"
    try:
        async with httpx.AsyncClient() as client:
            resp = await client.get(f"{base}{path}", timeout=5.0)
            resp.raise_for_status()
            output_json(resp.json())
    except (httpx.ConnectError, httpx.ConnectTimeout):
        exit_with_error(f"Cannot reach ldk dev on port {port}. Is it running?")


async def ldk_post(port: int, path: str, body: dict[str, Any]) -> None:
    """POST to a management API endpoint and print the JSON response."""
    base = f"http://localhost:{port}"
    try:
        async with httpx.AsyncClient() as client:
            resp = await client.post(f"{base}{path}", json=body, timeout=5.0)
            resp.raise_for_status()
            output_json(resp.json())
    except (httpx.ConnectError, httpx.ConnectTimeout):
        exit_with_error(f"Cannot reach ldk dev on port {port}. Is it running?")


def xml_to_dict(xml_text: str) -> dict[str, Any]:
    """Convert a simple XML response to a dict (single-level)."""
    root = ElementTree.fromstring(xml_text)
    result: dict[str, Any] = {}
    _walk_xml(root, result)
    return result


def _walk_xml(element: ElementTree.Element, target: dict[str, Any]) -> None:
    """Recursively walk XML elements into a dict."""
    tag = element.tag.split("}")[-1] if "}" in element.tag else element.tag
    children = list(element)
    if not children:
        target[tag] = element.text or ""
        return
    child_dict: dict[str, Any] = {}
    for child in children:
        child_tag = child.tag.split("}")[-1] if "}" in child.tag else child.tag
        if child_tag in child_dict:
            # Convert to list for repeated tags
            existing = child_dict[child_tag]
            if not isinstance(existing, list):
                child_dict[child_tag] = [existing]
            sub: dict[str, Any] = {}
            _walk_xml(child, sub)
            child_dict[child_tag].append(sub.get(child_tag, child.text or ""))
        else:
            _walk_xml(child, child_dict)
    target[tag] = child_dict
