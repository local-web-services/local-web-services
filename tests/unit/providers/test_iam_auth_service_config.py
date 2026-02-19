"""Unit tests for IamAuthServiceConfig dataclass."""

from __future__ import annotations

from lws.config.loader import IamAuthServiceConfig


class TestIamAuthServiceConfig:
    def test_defaults(self):
        # Arrange
        config = IamAuthServiceConfig()

        # Act
        actual_enabled = config.enabled
        actual_mode = config.mode

        # Assert
        assert actual_enabled is False
        assert actual_mode is None
