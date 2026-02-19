"""Unit tests for PermissionsMap without defaults."""

from __future__ import annotations

from lws.providers._shared.iam_permissions_map import PermissionsMap


class TestPermissionsMapNoDefaults:
    def test_no_defaults_empty_map(self):
        # Arrange
        pmap = PermissionsMap(load_defaults=False)

        # Act
        actual = pmap.get_required_actions("dynamodb", "get-item")

        # Assert
        assert actual is None
