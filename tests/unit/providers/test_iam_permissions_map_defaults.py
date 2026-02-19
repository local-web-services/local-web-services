"""Unit tests for PermissionsMap with bundled defaults."""

from __future__ import annotations

from lws.providers._shared.iam_permissions_map import PermissionsMap


class TestPermissionsMapDefaults:
    def test_loads_bundled_defaults(self):
        # Arrange
        pmap = PermissionsMap()

        # Act
        actual = pmap.get_required_actions("dynamodb", "get-item")

        # Assert
        assert actual == ["dynamodb:GetItem"]

    def test_unknown_service_returns_none(self):
        # Arrange
        pmap = PermissionsMap()

        # Act
        actual = pmap.get_required_actions("nonexistent", "get-item")

        # Assert
        assert actual is None

    def test_unknown_operation_returns_none(self):
        # Arrange
        pmap = PermissionsMap()

        # Act
        actual = pmap.get_required_actions("dynamodb", "nonexistent-op")

        # Assert
        assert actual is None
