"""Registry for fake server configurations loaded from ``.lws/fakes/``."""

from __future__ import annotations

from pathlib import Path

from lws.providers.fakeserver.dsl import load_fake_server
from lws.providers.fakeserver.models import FakeServerConfig


class FakeServerRegistry:
    """Load, store, and reload fake server configurations from disk."""

    def __init__(self, fakes_dir: Path) -> None:
        self._fakes_dir = fakes_dir
        self._servers: dict[str, FakeServerConfig] = {}

    @property
    def fakes_dir(self) -> Path:
        """Return the fakes directory path."""
        return self._fakes_dir

    @property
    def servers(self) -> dict[str, FakeServerConfig]:
        """Return a copy of loaded server configs."""
        return dict(self._servers)

    def load_all(self) -> dict[str, FakeServerConfig]:
        """Scan ``.lws/fakes/`` and load all fake server configs."""
        self._servers.clear()
        if not self._fakes_dir.exists():
            return self._servers

        for child in sorted(self._fakes_dir.iterdir()):
            if child.is_dir() and (child / "config.yaml").exists():
                config = load_fake_server(child)
                self._servers[config.name] = config
        return dict(self._servers)

    def load_one(self, name: str) -> FakeServerConfig | None:
        """Load or reload a single fake server by name."""
        fake_dir = self._fakes_dir / name
        if not (fake_dir / "config.yaml").exists():
            self._servers.pop(name, None)
            return None
        config = load_fake_server(fake_dir)
        self._servers[config.name] = config
        return config

    def get(self, name: str) -> FakeServerConfig | None:
        """Return a loaded fake server config by name."""
        return self._servers.get(name)

    def names(self) -> list[str]:
        """Return the names of all loaded fake servers."""
        return list(self._servers.keys())
