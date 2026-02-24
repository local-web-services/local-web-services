"""Unit tests for _write_slash_commands — idempotent overwrites."""

from __future__ import annotations

from lws.cli.init import _write_slash_commands


class TestWriteSlashCommandsIdempotent:
    def test_overwrites_existing_commands(self, tmp_path):
        # Arrange
        cmd_dir = tmp_path / ".claude" / "commands" / "lws"
        cmd_dir.mkdir(parents=True)
        (cmd_dir / "mock.md").write_text("old content")

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        actual_content = (cmd_dir / "mock.md").read_text()
        assert "old content" not in actual_content
