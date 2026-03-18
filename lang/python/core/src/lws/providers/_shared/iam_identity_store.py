"""Load IAM identities from a YAML file.

Each identity has a name, type (user/role), inline policies,
managed policy ARNs, and an optional boundary policy.
"""

from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

import yaml


@dataclass
class Identity:
    """A single IAM identity (user or role)."""

    name: str
    type: str = "user"
    inline_policies: list[dict] = field(default_factory=list)
    managed_policy_arns: list[str] = field(default_factory=list)
    boundary_policy: dict | None = None


class IdentityStore:
    """Load and query IAM identities from a YAML file."""

    def __init__(self, path: Path | None = None) -> None:
        self._identities: dict[str, Identity] = {}
        if path is not None and path.exists():
            self._load(path)

    def _load(self, path: Path) -> None:
        data = _load_yaml(path)
        raw_identities = data.get("identities", {})
        for name, props in raw_identities.items():
            inline_docs = []
            for ip in props.get("inline_policies", []):
                doc = ip.get("document", {})
                if doc:
                    inline_docs.append(doc)
            self._identities[name] = Identity(
                name=name,
                type=props.get("type", "user"),
                inline_policies=inline_docs,
                managed_policy_arns=props.get("policies", []),
                boundary_policy=props.get("boundary_policy"),
            )

    def get_identity(self, name: str) -> Identity | None:
        """Return an identity by name, or None if not found."""
        return self._identities.get(name)

    def get_policies(self, name: str) -> list[dict]:
        """Return the inline policy documents for an identity."""
        identity = self._identities.get(name)
        if identity is None:
            return []
        return list(identity.inline_policies)

    def get_boundary(self, name: str) -> dict | None:
        """Return the boundary policy for an identity, or None."""
        identity = self._identities.get(name)
        if identity is None:
            return None
        return identity.boundary_policy

    def register_identity(
        self,
        name: str,
        inline_policies: list[dict] | None = None,
        boundary_policy: dict | None = None,
    ) -> None:
        """Register or update an identity in the store at runtime."""
        self._identities[name] = Identity(
            name=name,
            inline_policies=inline_policies or [],
            boundary_policy=boundary_policy,
        )


def _load_yaml(path: Path) -> dict[str, Any]:
    """Load a YAML file and return a dict."""
    with open(path, encoding="utf-8") as fh:
        data = yaml.safe_load(fh)
    return data if isinstance(data, dict) else {}
