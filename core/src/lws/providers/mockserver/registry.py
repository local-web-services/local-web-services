"""Registry for mock server configurations loaded from ``.lws/mocks/``."""

from __future__ import annotations

from pathlib import Path

from lws.providers.mockserver.dsl import load_mock_server
from lws.providers.mockserver.models import MockServerConfig


class MockServerRegistry:
    """Load, store, and reload mock server configurations from disk."""

    def __init__(self, mocks_dir: Path) -> None:
        self._mocks_dir = mocks_dir
        self._servers: dict[str, MockServerConfig] = {}

    @property
    def mocks_dir(self) -> Path:
        """Return the mocks directory path."""
        return self._mocks_dir

    @property
    def servers(self) -> dict[str, MockServerConfig]:
        """Return a copy of loaded server configs."""
        return dict(self._servers)

    def load_all(self) -> dict[str, MockServerConfig]:
        """Scan ``.lws/mocks/`` and load all mock server configs."""
        self._servers.clear()
        if not self._mocks_dir.exists():
            return self._servers

        for child in sorted(self._mocks_dir.iterdir()):
            if child.is_dir() and (child / "config.yaml").exists():
                config = load_mock_server(child)
                self._servers[config.name] = config
        return dict(self._servers)

    def load_one(self, name: str) -> MockServerConfig | None:
        """Load or reload a single mock server by name."""
        mock_dir = self._mocks_dir / name
        if not (mock_dir / "config.yaml").exists():
            self._servers.pop(name, None)
            return None
        config = load_mock_server(mock_dir)
        self._servers[config.name] = config
        return config

    def get(self, name: str) -> MockServerConfig | None:
        """Return a loaded mock server config by name."""
        return self._servers.get(name)

    def names(self) -> list[str]:
        """Return the names of all loaded mock servers."""
        return list(self._servers.keys())
