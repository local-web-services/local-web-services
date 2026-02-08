"""Unit tests for the ldk invoke and ldk reset CLI commands."""

from __future__ import annotations

import re

from typer.testing import CliRunner

from ldk.cli.main import app


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
        result = runner.invoke(app, ["reset", "--yes", "--project-dir", str(tmp_path)])
        assert result.exit_code == 0
        assert "Nothing to reset" in result.output

    def test_reset_with_yes_flag(self, tmp_path):
        """Reset with --yes should skip confirmation and delete data."""
        data_dir = tmp_path / ".ldk"
        data_dir.mkdir()
        (data_dir / "test.db").write_text("data")
        (data_dir / "sqs").mkdir()
        (data_dir / "sqs" / "queue.db").write_text("data")

        result = runner.invoke(app, ["reset", "--yes", "--project-dir", str(tmp_path)])
        assert result.exit_code == 0
        assert "Deleted" in result.output

        # Verify data was actually deleted
        remaining = list(data_dir.iterdir())
        assert len(remaining) == 0

    def test_reset_without_yes_declines(self, tmp_path):
        """Reset without --yes should prompt and respect 'n'."""
        data_dir = tmp_path / ".ldk"
        data_dir.mkdir()
        (data_dir / "test.db").write_text("data")

        result = runner.invoke(
            app,
            ["reset", "--project-dir", str(tmp_path)],
            input="n\n",
        )
        assert result.exit_code == 0
        assert "Aborted" in result.output
        # File should still exist
        assert (data_dir / "test.db").exists()

    def test_reset_empty_data_dir(self, tmp_path):
        """Reset when data directory exists but is empty."""
        data_dir = tmp_path / ".ldk"
        data_dir.mkdir()

        result = runner.invoke(app, ["reset", "--yes", "--project-dir", str(tmp_path)])
        assert result.exit_code == 0
        assert "empty" in result.output.lower() or "Nothing to reset" in result.output
