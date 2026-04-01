"""Tests for enterprise seed file — parses without error and OU structure is correct."""

from __future__ import annotations

from lws.providers.organizations._org_config import load_organizations_config
from lws.seeds._resolver import resolve_seed_path


class TestEnterpriseSeedParse:
    def test_enterprise_seed_parses_without_error(self) -> None:
        # Arrange
        config_path = resolve_seed_path("enterprise")

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_account_count = len(state.accounts)
        expected_minimum_accounts = 50
        assert actual_account_count >= expected_minimum_accounts

    def test_enterprise_seed_has_six_top_level_ous(self) -> None:
        # Arrange
        config_path = resolve_seed_path("enterprise")

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_ou_names = {ou["Name"] for ou in state.ous.values()}
        expected_ou_names = {
            "Production",
            "NonProduction",
            "Sandbox",
            "Security",
            "SharedServices",
            "Decommissioned",
        }
        assert expected_ou_names.issubset(actual_ou_names)

    def test_enterprise_seed_accounts_have_required_tags(self) -> None:
        # Arrange
        config_path = resolve_seed_path("enterprise")
        required_tag_keys = {"env", "team", "cost-center", "data-classification", "region-primary"}

        # Act
        state = load_organizations_config(config_path)

        # Assert
        for account_id, tags in state.resource_tags.items():
            actual_tag_keys = set(tags.keys())
            assert required_tag_keys.issubset(actual_tag_keys), (
                f"Account {account_id} missing required tags: "
                f"{required_tag_keys - actual_tag_keys}"
            )
