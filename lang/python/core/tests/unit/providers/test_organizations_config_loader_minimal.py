"""Tests for load_organizations_config — minimal config with optional fields absent."""

from __future__ import annotations

import pathlib

from lws.providers.organizations._org_config import load_organizations_config


def _write_yaml(tmp_path: pathlib.Path, content: str) -> str:
    p = tmp_path / "org.yaml"
    p.write_text(content)
    return str(p)


_MINIMAL_CONFIG = """\
organization:
  id: o-minimal9999
  master_account_id: "000000000000"
  feature_set: ALL

roots:
  - id: r-0001
    name: Root

ous: []
accounts: []
"""


class TestLoadOrganizationsConfigMissingOptionalFields:
    def test_minimal_config_produces_empty_collections(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _MINIMAL_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_ou_count = len(state.ous)
        expected_ou_count = 0
        assert actual_ou_count == expected_ou_count

    def test_minimal_config_organization_set(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _MINIMAL_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_feature_set = state.organization["FeatureSet"]
        expected_feature_set = "ALL"
        assert actual_feature_set == expected_feature_set
