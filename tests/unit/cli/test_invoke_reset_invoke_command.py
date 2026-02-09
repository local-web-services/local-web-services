"""Unit tests for the ldk invoke and ldk reset CLI commands."""

from __future__ import annotations

import re

from typer.testing import CliRunner

from lws.cli.ldk import app


def _strip_ansi(text: str) -> str:
    return re.sub(r"\x1b\[[0-9;]*m", "", text)


runner = CliRunner()


class TestInvokeCommand:
    """Tests for ``ldk invoke`` argument parsing."""

    def test_invoke_appears_in_help(self):
        result = runner.invoke(app, ["--help"])
        assert "invoke" in result.output

    def test_invoke_requires_function_name(self):
        result = runner.invoke(app, ["invoke"])
        # Should fail because --function-name is required
        assert result.exit_code != 0

    def test_invoke_help_shows_options(self):
        result = runner.invoke(app, ["invoke", "--help"])
        output = _strip_ansi(result.output)
        assert "--function-name" in output
        assert "--event" in output
        assert "--event-file" in output

    def test_invoke_with_invalid_json_event(self):
        result = runner.invoke(app, ["invoke", "--function-name", "f", "--event", "not-json"])
        assert result.exit_code != 0

    def test_invoke_with_missing_event_file(self):
        result = runner.invoke(
            app,
            ["invoke", "--function-name", "f", "--event-file", "/nonexistent/file.json"],
        )
        assert result.exit_code != 0
