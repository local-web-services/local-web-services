"""Unit tests for ldk CLI main module."""

from __future__ import annotations


class TestDevCommand:
    """Tests for the dev command argument parsing."""

    def test_app_has_dev_command(self):
        from typer.testing import CliRunner

        from lws.cli.ldk import app

        runner = CliRunner()
        result = runner.invoke(app, ["--help"])
        assert "dev" in result.output
