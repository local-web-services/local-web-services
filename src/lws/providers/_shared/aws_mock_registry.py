"""Registry that discovers and loads AWS mock configurations.

Scans ``.lws/mocks/`` directories for those with a ``service:`` field in
``config.yaml``, indicating they are AWS operation mocks rather than
generic mock servers.
"""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_mock_dsl import load_aws_mock
from lws.providers._shared.aws_operation_mock import AwsMockConfig


class AwsMockRegistry:
    """Discover and load AWS mock configs from ``.lws/mocks/``."""

    def __init__(self, mocks_dir: Path) -> None:
        self._mocks_dir = mocks_dir

    def load_all(self) -> dict[str, AwsMockConfig]:
        """Scan all mock directories and return ``{service: merged_config}``."""
        if not self._mocks_dir.exists():
            return {}

        configs: dict[str, AwsMockConfig] = {}
        for child in sorted(self._mocks_dir.iterdir()):
            if not child.is_dir():
                continue
            config = load_aws_mock(child)
            if config is None:
                continue
            service = config.service
            if service in configs:
                configs[service].rules.extend(config.rules)
                if not config.enabled:
                    configs[service].enabled = False
            else:
                configs[service] = config
        return configs

    def load_one(self, name: str) -> AwsMockConfig | None:
        """Load a single mock directory by name."""
        mock_dir = self._mocks_dir / name
        if not mock_dir.exists():
            return None
        return load_aws_mock(mock_dir)
