"""Unit tests for PermissionsMap with user overrides."""

from __future__ import annotations

from pathlib import Path

import yaml

from lws.providers._shared.iam_permissions_map import PermissionsMap


class TestPermissionsMapOverrides:
    def test_user_overrides_merge(self, tmp_path):
        # Arrange
        overrides_yaml = {
            "permissions": {
                "dynamodb": {
                    "custom-op": {"actions": ["dynamodb:CustomAction"]},
                }
            }
        }
        override_path = tmp_path / "permissions.yaml"
        override_path.write_text(yaml.dump(overrides_yaml))

        # Act
        pmap = PermissionsMap(override_path)
        actual_custom = pmap.get_required_actions("dynamodb", "custom-op")
        actual_default = pmap.get_required_actions("dynamodb", "get-item")

        # Assert
        assert actual_custom == ["dynamodb:CustomAction"]
        assert actual_default == ["dynamodb:GetItem"]

    def test_missing_override_file_uses_defaults(self):
        # Arrange
        missing_path = Path("/nonexistent/permissions.yaml")

        # Act
        pmap = PermissionsMap(missing_path)
        actual = pmap.get_required_actions("s3", "get-object")

        # Assert
        assert actual == ["s3:GetObject"]
