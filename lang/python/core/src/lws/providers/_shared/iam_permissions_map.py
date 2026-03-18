"""Map AWS operations to required IAM actions.

Loads a bundled default permissions map and optionally merges
user-provided overrides from a YAML file.
"""

from __future__ import annotations

from pathlib import Path
from typing import Any

import yaml

_BUNDLED_DEFAULTS = Path(__file__).parent / "iam_default_permissions.yaml"


class PermissionsMap:
    """Map (service, operation) pairs to lists of required IAM actions."""

    def __init__(
        self,
        user_overrides_path: Path | None = None,
        *,
        load_defaults: bool = True,
    ) -> None:
        self._map: dict[str, dict[str, list[str]]] = {}
        if load_defaults and _BUNDLED_DEFAULTS.exists():
            self._merge(_load_yaml(_BUNDLED_DEFAULTS))
        if user_overrides_path is not None and user_overrides_path.exists():
            self._merge(_load_yaml(user_overrides_path))

    def _merge(self, data: dict[str, Any]) -> None:
        permissions = data.get("permissions", {})
        for service, ops in permissions.items():
            if service not in self._map:
                self._map[service] = {}
            for op, spec in ops.items():
                actions = spec.get("actions", []) if isinstance(spec, dict) else []
                self._map[service][op] = actions

    def get_required_actions(self, service: str, operation: str) -> list[str] | None:
        """Return the required IAM actions for a service operation.

        Returns None if the operation is not in the map (unknown operation).
        """
        service_map = self._map.get(service)
        if service_map is None:
            return None
        return service_map.get(operation)


def _load_yaml(path: Path) -> dict[str, Any]:
    """Load a YAML file and return a dict."""
    with open(path, encoding="utf-8") as fh:
        data = yaml.safe_load(fh)
    return data if isinstance(data, dict) else {}
