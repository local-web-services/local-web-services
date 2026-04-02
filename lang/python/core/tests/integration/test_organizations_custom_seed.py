"""Integration tests for Organizations custom seed file loading."""

from __future__ import annotations

import pathlib

from starlette.testclient import TestClient

from lws.providers.organizations.routes import create_organizations_app
from lws.seeds._resolver import resolve_seed_path

from ._helpers import CUSTOM_SEED_YAML, post


class TestCustomSeedFileLoadedViaFlag:
    def test_list_accounts_returns_exact_count(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        seed_file = tmp_path / "custom.yaml"
        seed_file.write_text(CUSTOM_SEED_YAML)
        config_path = resolve_seed_path(str(seed_file))
        app, _ = create_organizations_app(config_path=config_path)
        config_client = TestClient(app, raise_server_exceptions=False)

        # Act
        status, body = post(config_client, "ListAccounts", {})

        # Assert
        actual_count = len(body.get("Accounts", []))
        expected_count = 3
        assert status == 200
        assert actual_count == expected_count
