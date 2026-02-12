"""Unit tests for is_experimental_service."""

from __future__ import annotations


class TestIsExperimentalService:
    def test_known_experimental_service_returns_true(self):
        # Arrange
        from lws.cli.experimental import is_experimental_service

        # Act
        actual = is_experimental_service("neptune")

        # Assert
        assert actual is True

    def test_stable_service_returns_false(self):
        # Arrange
        from lws.cli.experimental import is_experimental_service

        # Act
        actual = is_experimental_service("dynamodb")

        # Assert
        assert actual is False

    def test_unknown_service_returns_false(self):
        # Arrange
        from lws.cli.experimental import is_experimental_service

        # Act
        actual = is_experimental_service("nonexistent")

        # Assert
        assert actual is False
