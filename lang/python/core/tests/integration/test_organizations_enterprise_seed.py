"""Integration tests for Organizations enterprise seed loading."""

from __future__ import annotations

from starlette.testclient import TestClient

from lws.providers.organizations.routes import create_organizations_app
from lws.seeds._resolver import resolve_seed_path

from ._helpers import post


class TestEnterpriseSeedLoadedViaFlag:
    def test_list_accounts_returns_fifty_or_more(self) -> None:
        # Arrange
        config_path = resolve_seed_path("enterprise")
        app, _ = create_organizations_app(config_path=config_path)
        config_client = TestClient(app, raise_server_exceptions=False)

        # Act
        status, body = post(config_client, "ListAccounts", {})

        # Assert
        actual_count = len(body.get("Accounts", []))
        expected_minimum = 50
        assert status == 200
        assert actual_count >= expected_minimum
