"""Unit tests for the ldk invoke and ldk reset CLI commands."""

from __future__ import annotations

import re

from typer.testing import CliRunner

from lws.cli.ldk import app


def _strip_ansi(text: str) -> str:
    return re.sub(r"\x1b\[[0-9;]*m", "", text)


runner = CliRunner()


class TestResetCommand:
    """Tests for ``ldk reset`` argument parsing."""

    def test_reset_appears_in_help(self):
        result = runner.invoke(app, ["--help"])
        assert "reset" in result.output

    def test_reset_help_shows_options(self):
        result = runner.invoke(app, ["reset", "--help"])
        output = _strip_ansi(result.output)
        assert "--yes" in output
        assert "--project-dir" in output

    def test_reset_with_no_data_dir(self, tmp_path):
        """Reset when no data directory exists should exit cleanly."""
        # Arrange
        expected_exit_code = 0
        expected_message = "Nothing to reset"

        # Act
        result = runner.invoke(app, ["reset", "--yes", "--project-dir", str(tmp_path)])

        # Assert
        assert result.exit_code == expected_exit_code
        assert expected_message in result.output

    def test_reset_with_yes_flag(self, tmp_path):
        """Reset with --yes should skip confirmation and delete data."""
        # Arrange
        expected_exit_code = 0
        expected_message = "Deleted"
        expected_remaining_count = 0
        data_dir = tmp_path / ".ldk"
        data_dir.mkdir()
        (data_dir / "test.db").write_text("data")
        (data_dir / "sqs").mkdir()
        (data_dir / "sqs" / "queue.db").write_text("data")

        # Act
        result = runner.invoke(app, ["reset", "--yes", "--project-dir", str(tmp_path)])

        # Assert
        assert result.exit_code == expected_exit_code
        assert expected_message in result.output
        actual_remaining_count = len(list(data_dir.iterdir()))
        assert actual_remaining_count == expected_remaining_count

    def test_reset_without_yes_declines(self, tmp_path):
        """Reset without --yes should prompt and respect 'n'."""
        # Arrange
        expected_exit_code = 0
        expected_message = "Aborted"
        data_dir = tmp_path / ".ldk"
        data_dir.mkdir()
        (data_dir / "test.db").write_text("data")

        # Act
        result = runner.invoke(
            app,
            ["reset", "--project-dir", str(tmp_path)],
            input="n\n",
        )

        # Assert
        assert result.exit_code == expected_exit_code
        assert expected_message in result.output
        assert (data_dir / "test.db").exists()

    def test_reset_empty_data_dir(self, tmp_path):
        """Reset when data directory exists but is empty."""
        # Arrange
        expected_exit_code = 0
        data_dir = tmp_path / ".ldk"
        data_dir.mkdir()

        # Act
        result = runner.invoke(app, ["reset", "--yes", "--project-dir", str(tmp_path)])

        # Assert
        assert result.exit_code == expected_exit_code
        assert "empty" in result.output.lower() or "Nothing to reset" in result.output
