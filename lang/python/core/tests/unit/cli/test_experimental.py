"""Unit tests for is_experimental_service."""

from __future__ import annotations


class TestIsExperimentalService:
    def test_known_experimental_service_returns_true(self):
        # Arrange
        from lws.cli.experimental import EXPERIMENTAL_SERVICES, is_experimental_service

        EXPERIMENTAL_SERVICES.add("test-service")

        # Act
        actual = is_experimental_service("test-service")

        # Assert
        assert actual is True

        # Cleanup
        EXPERIMENTAL_SERVICES.discard("test-service")

    def test_stable_service_returns_false(self):
        # Arrange
        from lws.cli.experimental import is_experimental_service

        # Act
        actual = is_experimental_service("chaos")

        # Assert
        assert actual is False

    def test_unknown_service_returns_false(self):
        # Arrange
        from lws.cli.experimental import is_experimental_service

        # Act
        actual = is_experimental_service("nonexistent")

        # Assert
        assert actual is False
