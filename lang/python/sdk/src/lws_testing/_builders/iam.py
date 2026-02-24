"""Fluent builder for configuring IAM authorization at runtime."""

from __future__ import annotations

from typing import Any

import httpx


class IamBuilder:
    """Fluent builder for runtime IAM auth configuration.

    Usage::

        # Switch to enforce mode
        session.iam.mode("enforce").apply()

        # Register a read-only identity
        session.iam.identity("readonly").allow(["dynamodb:GetItem"]).apply()
    """

    def __init__(self, mgmt_port: int) -> None:
        self._mgmt_port = mgmt_port
        self._updates: dict[str, Any] = {}
        self._identities: dict[str, Any] = {}

    def mode(self, mode: str) -> IamBuilder:
        """Set the global IAM auth mode (``"enforce"``, ``"audit"``, ``"disabled"``)."""
        self._updates["mode"] = mode
        return self

    def default_identity(self, name: str) -> IamBuilder:
        """Set the default identity used when no identity header is present."""
        self._updates["default_identity"] = name
        return self

    def identity(self, name: str) -> _IdentityBuilder:
        """Start configuring a named identity."""
        return _IdentityBuilder(self, name)

    def _register_identity(self, name: str, config: dict[str, Any]) -> None:
        self._identities[name] = config

    def apply(self) -> None:
        """Push all pending IAM configuration to the management API."""
        payload: dict[str, Any] = dict(self._updates)
        if self._identities:
            payload["identities"] = self._identities
        httpx.post(
            f"http://127.0.0.1:{self._mgmt_port}/_ldk/iam-auth",
            json=payload,
            timeout=5.0,
        )
        self._updates = {}
        self._identities = {}


class _IdentityBuilder:
    """Configure a single named IAM identity."""

    def __init__(self, parent: IamBuilder, name: str) -> None:
        self._parent = parent
        self._name = name
        self._inline_policies: list[dict[str, Any]] = []
        self._boundary: dict[str, Any] | None = None

    def allow(self, actions: list[str], resource: str = "*") -> _IdentityBuilder:
        """Add an Allow statement to this identity's inline policy."""
        self._inline_policies.append(
            {
                "name": f"inline-{len(self._inline_policies)}",
                "document": {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Allow",
                            "Action": actions,
                            "Resource": resource,
                        }
                    ],
                },
            }
        )
        return self

    def deny(self, actions: list[str], resource: str = "*") -> _IdentityBuilder:
        """Add an explicit Deny statement to this identity's inline policy."""
        self._inline_policies.append(
            {
                "name": f"inline-deny-{len(self._inline_policies)}",
                "document": {
                    "Version": "2012-10-17",
                    "Statement": [
                        {
                            "Effect": "Deny",
                            "Action": actions,
                            "Resource": resource,
                        }
                    ],
                },
            }
        )
        return self

    def boundary(self, actions: list[str], resource: str = "*") -> _IdentityBuilder:
        """Set a permissions boundary for this identity."""
        self._boundary = {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": actions,
                    "Resource": resource,
                }
            ],
        }
        return self

    def apply(self) -> IamBuilder:
        """Register the identity and return the parent builder for chaining."""
        config: dict[str, Any] = {"inline_policies": self._inline_policies}
        if self._boundary is not None:
            config["boundary_policy"] = self._boundary
        self._parent._register_identity(self._name, config)
        return self._parent
