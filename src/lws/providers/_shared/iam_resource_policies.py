"""Load resource policies from a YAML file.

Resource policies are per-service, per-resource policy documents
(e.g. S3 bucket policies).
"""

from __future__ import annotations

from pathlib import Path
from typing import Any

import yaml


class ResourcePolicyStore:
    """Load and query resource policies from a YAML file."""

    def __init__(self, path: Path | None = None) -> None:
        self._policies: dict[str, dict[str, dict]] = {}
        if path is not None and path.exists():
            self._load(path)

    def _load(self, path: Path) -> None:
        data = _load_yaml(path)
        self._policies = data.get("resource_policies", {})

    def get_policy(self, service: str, resource_name: str) -> dict | None:
        """Return the resource policy for a service/resource, or None."""
        service_policies = self._policies.get(service)
        if service_policies is None:
            return None
        return service_policies.get(resource_name)


def _load_yaml(path: Path) -> dict[str, Any]:
    """Load a YAML file and return a dict."""
    with open(path, encoding="utf-8") as fh:
        data = yaml.safe_load(fh)
    return data if isinstance(data, dict) else {}
