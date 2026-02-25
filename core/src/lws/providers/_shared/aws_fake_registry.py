"""Registry that discovers and loads AWS fake configurations.

Scans ``.lws/fakes/`` directories for those with a ``service:`` field in
``config.yaml``, indicating they are AWS operation fakes rather than
generic fake servers.
"""

from __future__ import annotations

from pathlib import Path

from lws.providers._shared.aws_fake_dsl import load_aws_fake
from lws.providers._shared.aws_operation_fake import AwsFakeConfig


class AwsFakeRegistry:
    """Discover and load AWS fake configs from ``.lws/fakes/``."""

    def __init__(self, fakes_dir: Path) -> None:
        self._fakes_dir = fakes_dir

    def load_all(self) -> dict[str, AwsFakeConfig]:
        """Scan all fake directories and return ``{service: merged_config}``."""
        if not self._fakes_dir.exists():
            return {}

        configs: dict[str, AwsFakeConfig] = {}
        for child in sorted(self._fakes_dir.iterdir()):
            if not child.is_dir():
                continue
            config = load_aws_fake(child)
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

    def load_one(self, name: str) -> AwsFakeConfig | None:
        """Load a single fake directory by name."""
        fake_dir = self._fakes_dir / name
        if not fake_dir.exists():
            return None
        return load_aws_fake(fake_dir)
