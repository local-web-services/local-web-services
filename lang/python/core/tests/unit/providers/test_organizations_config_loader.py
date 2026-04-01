"""Tests for load_organizations_config — happy path."""

from __future__ import annotations

import pathlib

from lws.providers.organizations._org_config import load_organizations_config


def _write_yaml(tmp_path: pathlib.Path, content: str) -> str:
    p = tmp_path / "org.yaml"
    p.write_text(content)
    return str(p)


_BASIC_CONFIG = """\
organization:
  id: o-test123456
  master_account_id: "000000000000"
  feature_set: ALL

roots:
  - id: r-0001
    name: Root

ous:
  - id: ou-prod-0001
    name: Production
    parent: r-0001
  - id: ou-dev-0002
    name: Development
    parent: r-0001

accounts:
  - id: "111111111111"
    name: prod-payments
    email: prod-payments@example.com
    ou: ou-prod-0001
    tags:
      env: prod
  - id: "222222222222"
    name: dev-tools
    email: dev-tools@example.com
    ou: ou-dev-0002
  - id: "333333333333"
    name: dev-infra
    email: dev-infra@example.com
    ou: ou-dev-0002
"""


class TestLoadOrganizationsConfigHappyPath:
    def test_organization_populated(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _BASIC_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_org_id = state.organization["Id"]
        expected_org_id = "o-test123456"
        assert actual_org_id == expected_org_id

    def test_root_populated(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _BASIC_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_root_id = state.root["Id"]
        expected_root_id = "r-0001"
        assert actual_root_id == expected_root_id

    def test_ous_populated(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _BASIC_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_ou_ids = set(state.ous.keys())
        expected_ou_ids = {"ou-prod-0001", "ou-dev-0002"}
        assert actual_ou_ids == expected_ou_ids

    def test_accounts_populated(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _BASIC_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_account_ids = set(state.accounts.keys())
        expected_account_ids = {"111111111111", "222222222222", "333333333333"}
        assert actual_account_ids == expected_account_ids

    def test_account_parent_mapping_populated(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _BASIC_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_parent = state.account_parents["111111111111"]
        expected_parent = "ou-prod-0001"
        assert actual_parent == expected_parent

    def test_account_tags_populated(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _BASIC_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_tags = state.resource_tags.get("111111111111")
        expected_tags = {"env": "prod"}
        assert actual_tags == expected_tags

    def test_account_without_tags_has_no_entry(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _BASIC_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_tags = state.resource_tags.get("222222222222")
        assert actual_tags is None
