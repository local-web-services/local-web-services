"""Tests for project mode resolution in ldk dev."""

from __future__ import annotations

import click.exceptions
import pytest

from lws.config.loader import LdkConfig


class TestResolveMode:
    def test_cli_override_cdk(self, tmp_path) -> None:
        from lws.cli.ldk import _resolve_mode

        # Arrange
        expected_mode = "cdk"
        config = LdkConfig()

        # Act
        actual = _resolve_mode(tmp_path, config, expected_mode)

        # Assert
        assert actual == expected_mode

    def test_cli_override_terraform(self, tmp_path) -> None:
        from lws.cli.ldk import _resolve_mode

        # Arrange
        expected_mode = "terraform"
        config = LdkConfig()

        # Act
        actual = _resolve_mode(tmp_path, config, expected_mode)

        # Assert
        assert actual == expected_mode

    def test_config_mode_used_when_no_override(self, tmp_path) -> None:
        from lws.cli.ldk import _resolve_mode

        # Arrange
        expected_mode = "terraform"
        config = LdkConfig(mode=expected_mode)

        # Act
        actual = _resolve_mode(tmp_path, config, None)

        # Assert
        assert actual == expected_mode

    def test_invalid_mode_raises(self, tmp_path) -> None:
        from lws.cli.ldk import _resolve_mode

        config = LdkConfig()
        with pytest.raises(click.exceptions.Exit):
            _resolve_mode(tmp_path, config, "invalid")

    def test_auto_detect_terraform(self, tmp_path) -> None:
        from lws.cli.ldk import _resolve_mode

        # Arrange
        expected_mode = "terraform"
        (tmp_path / "main.tf").write_text("")
        config = LdkConfig()

        # Act
        actual = _resolve_mode(tmp_path, config, None)

        # Assert
        assert actual == expected_mode

    def test_auto_detect_cdk(self, tmp_path) -> None:
        from lws.cli.ldk import _resolve_mode

        # Arrange
        expected_mode = "cdk"
        (tmp_path / "cdk.out").mkdir()
        config = LdkConfig()

        # Act
        actual = _resolve_mode(tmp_path, config, None)

        # Assert
        assert actual == expected_mode

    def test_ambiguous_raises(self, tmp_path) -> None:
        from lws.cli.ldk import _resolve_mode

        (tmp_path / "main.tf").write_text("")
        (tmp_path / "cdk.out").mkdir()
        config = LdkConfig()
        with pytest.raises(click.exceptions.Exit):
            _resolve_mode(tmp_path, config, None)

    def test_no_project_raises(self, tmp_path) -> None:
        from lws.cli.ldk import _resolve_mode

        config = LdkConfig()
        with pytest.raises(click.exceptions.Exit):
            _resolve_mode(tmp_path, config, None)
