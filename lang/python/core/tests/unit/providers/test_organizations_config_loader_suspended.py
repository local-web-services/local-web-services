"""Tests for load_organizations_config — SUSPENDED account status."""

from __future__ import annotations

import pathlib

from lws.providers.organizations._org_config import load_organizations_config


def _write_yaml(tmp_path: pathlib.Path, content: str) -> str:
    p = tmp_path / "org.yaml"
    p.write_text(content)
    return str(p)


_SUSPENDED_CONFIG = """\
organization:
  id: o-susp123456
  master_account_id: "000000000000"
  feature_set: ALL

roots:
  - id: r-0001
    name: Root

ous: []

accounts:
  - id: "444444444444"
    name: suspended-acct
    email: suspended@example.com
    ou: r-0001
    status: SUSPENDED
"""


class TestLoadOrganizationsConfigSuspendedStatus:
    def test_suspended_account_has_correct_status(self, tmp_path: pathlib.Path) -> None:
        # Arrange
        config_path = _write_yaml(tmp_path, _SUSPENDED_CONFIG)

        # Act
        state = load_organizations_config(config_path)

        # Assert
        actual_status = state.accounts["444444444444"]["Status"]
        expected_status = "SUSPENDED"
        assert actual_status == expected_status
