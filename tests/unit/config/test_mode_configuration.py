"""Tests for the mode configuration field in LdkConfig."""

from __future__ import annotations

from lws.config.loader import LdkConfig


class TestModeConfiguration:
    def test_default_mode_is_none(self) -> None:
        # Arrange / Act
        config = LdkConfig()

        # Assert
        assert config.mode is None

    def test_mode_can_be_set_to_cdk(self) -> None:
        # Arrange
        expected_mode = "cdk"

        # Act
        config = LdkConfig(mode=expected_mode)

        # Assert
        assert config.mode == expected_mode

    def test_mode_can_be_set_to_terraform(self) -> None:
        # Arrange
        expected_mode = "terraform"

        # Act
        config = LdkConfig(mode=expected_mode)

        # Assert
        assert config.mode == expected_mode
