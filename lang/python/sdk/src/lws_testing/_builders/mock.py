"""Fluent builder for configuring AWS operation mocks."""

from __future__ import annotations

from typing import Any

import httpx


class MockBuilder:
    """Fluent builder for AWS service mock responses.

    Usage::

        session.mock("dynamodb").operation("PutItem").respond(
            status=500,
            body={"__type": "ProvisionedThroughputExceededException"},
        )
    """

    def __init__(self, service: str, mgmt_port: int) -> None:
        self._service = service
        self._mgmt_port = mgmt_port
        self._rules: list[dict[str, Any]] = []

    def operation(self, operation_name: str) -> _MockRuleBuilder:
        """Start building a mock rule for *operation_name*."""
        return _MockRuleBuilder(self, operation_name)

    def _add_rule(self, rule: dict[str, Any]) -> MockBuilder:
        self._rules.append(rule)
        self._apply()
        return self

    def _apply(self) -> None:
        """Push the current rules to the management API."""
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/aws-mock",
            json={self._service: {"enabled": True, "rules": self._rules}},
            timeout=5.0,
        )

    def clear(self) -> None:
        """Remove all mock rules for this service."""
        self._rules = []
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/aws-mock",
            json={self._service: {"enabled": False, "rules": []}},
            timeout=5.0,
        )


class _MockRuleBuilder:
    """Intermediate builder — configure a single mock rule."""

    def __init__(self, parent: MockBuilder, operation: str) -> None:
        self._parent = parent
        self._operation = operation
        self._match_headers: dict[str, str] = {}

    def with_header(self, name: str, value: str) -> _MockRuleBuilder:
        """Add an additional header match constraint."""
        self._match_headers[name] = value
        return self

    def respond(
        self,
        status: int = 200,
        body: str | dict[str, Any] = "",
        content_type: str = "application/json",
        delay_ms: int = 0,
    ) -> MockBuilder:
        """Set the response and register the rule.

        Args:
            status: HTTP status code to return.
            body: Response body (dict will be JSON-encoded).
            content_type: Response Content-Type header.
            delay_ms: Artificial delay before responding.
        """
        import json

        if isinstance(body, dict):
            body_str = json.dumps(body)
        else:
            body_str = body

        rule: dict[str, Any] = {
            "operation": self._operation,
            "match_headers": self._match_headers,
            "response": {
                "status": status,
                "content_type": content_type,
                "delay_ms": delay_ms,
            },
        }
        if body_str:
            rule["response"]["body"] = body_str

        return self._parent._add_rule(rule)

    def error(self, error_type: str, message: str = "", status: int = 400) -> MockBuilder:
        """Respond with a structured AWS error."""
        import json

        body = json.dumps({"__type": error_type, "message": message})
        return self.respond(status=status, body=body)
