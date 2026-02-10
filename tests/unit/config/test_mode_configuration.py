"""Tests for the mode configuration field in LdkConfig."""

from __future__ import annotations

from lws.config.loader import LdkConfig


class TestModeConfiguration:
    def test_default_mode_is_none(self) -> None:
        config = LdkConfig()
        assert config.mode is None

    def test_mode_can_be_set_to_cdk(self) -> None:
        config = LdkConfig(mode="cdk")
        assert config.mode == "cdk"

    def test_mode_can_be_set_to_terraform(self) -> None:
        config = LdkConfig(mode="terraform")
        assert config.mode == "terraform"
