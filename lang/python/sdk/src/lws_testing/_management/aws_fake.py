"""HTTP client wrapping the /_ldk/aws-fake management API for AWS fake operations."""

from __future__ import annotations

from typing import Any

import httpx


class AwsFakeClient:
    """Client for the LWS AWS fake management API (/_ldk/aws-fake).

    Returned by ``lws_session.client("aws_fake")``.  Provides methods to
    create, configure, and delete AWS service fake interceptors.

    Usage::

        af = session.client("aws_fake")
        af.create("dynamodb")
        af.add_operation("dynamodb", "ListTables", status=200, body={"TableNames": []})
    """

    def __init__(self, mgmt_port: int) -> None:
        self._mgmt_port = mgmt_port
        self._base = f"http://127.0.0.1:{mgmt_port}/_ldk/aws-fake"

    def get_all_status(self) -> dict[str, Any]:
        """Return current AWS fake config for all services."""
        resp = httpx.get(self._base, timeout=5.0)
        resp.raise_for_status()
        return resp.json()

    def get_status(self, service: str) -> dict[str, Any]:
        """Return current AWS fake config for a specific service."""
        all_status = self.get_all_status()
        if service not in all_status:
            raise KeyError(f"Service '{service}' not found in aws-fake configs")
        return all_status[service]

    def create(self, service: str) -> dict[str, Any]:
        """Enable an AWS fake for a service (equivalent to 'create').

        Raises ``ValueError`` if the fake is already enabled.
        """
        current = self.get_status(service)
        if current.get("enabled"):
            raise ValueError(f"AWS fake for '{service}' already exists (already enabled)")
        resp = httpx.post(
            self._base,
            json={service: {"enabled": True, "rules": []}},
            timeout=5.0,
        )
        resp.raise_for_status()
        return resp.json()

    def delete(self, service: str) -> dict[str, Any]:
        """Disable an AWS fake for a service (equivalent to 'delete').

        Raises ``KeyError`` if the fake is not currently enabled.
        """
        current = self.get_status(service)
        if not current.get("enabled"):
            raise KeyError(f"AWS fake for '{service}' does not exist (not enabled)")
        resp = httpx.post(
            self._base,
            json={service: {"enabled": False, "rules": []}},
            timeout=5.0,
        )
        resp.raise_for_status()
        return resp.json()

    def add_operation(
        self,
        service: str,
        operation: str,
        status: int = 200,
        body: Any = None,
        headers: dict[str, str] | None = None,
        header_filter: dict[str, str] | None = None,
    ) -> dict[str, Any]:
        """Add an operation rule to an AWS fake."""
        import json  # pylint: disable=import-outside-toplevel

        current = self.get_status(service)
        existing_rules = current.get("rules", [])
        body_str = json.dumps(body) if isinstance(body, dict) else (body or "")
        rule: dict[str, Any] = {
            "operation": operation,
            "match_headers": header_filter or {},
            "response": {
                "status": status,
                "content_type": "application/json",
                "delay_ms": 0,
                "headers": headers or {},
            },
        }
        if body_str:
            rule["response"]["body"] = body_str
        new_rules = existing_rules + [rule]
        resp = httpx.post(
            self._base,
            json={service: {"enabled": True, "rules": new_rules}},
            timeout=5.0,
        )
        resp.raise_for_status()
        return resp.json()

    def remove_operation(self, service: str, operation: str) -> dict[str, Any]:
        """Remove an operation rule from an AWS fake."""
        current = self.get_status(service)
        existing_rules = current.get("rules", [])
        new_rules = [r for r in existing_rules if r.get("operation") != operation]
        if len(new_rules) == len(existing_rules):
            raise KeyError(f"Operation '{operation}' not found in AWS fake for '{service}'")
        resp = httpx.post(
            self._base,
            json={service: {"enabled": current.get("enabled", True), "rules": new_rules}},
            timeout=5.0,
        )
        resp.raise_for_status()
        return resp.json()
