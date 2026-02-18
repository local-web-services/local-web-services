"""Unit tests for _write_slash_commands — creating commands."""

from __future__ import annotations

from lws.cli.init import _write_slash_commands


class TestWriteSlashCommands:
    def test_creates_mock_command(self, tmp_path):
        # Arrange
        expected_file = tmp_path / ".claude" / "commands" / "lws" / "mock.md"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        assert expected_file.exists()

    def test_creates_chaos_command(self, tmp_path):
        # Arrange
        expected_file = tmp_path / ".claude" / "commands" / "lws" / "chaos.md"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        assert expected_file.exists()

    def test_returns_written_paths(self, tmp_path):
        # Arrange
        expected_count = 2

        # Act
        actual_paths = _write_slash_commands(tmp_path)

        # Assert
        assert len(actual_paths) == expected_count

    def test_mock_command_contains_instructions(self, tmp_path):
        # Arrange
        expected_text = "AWS operation mocks"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        actual_content = (tmp_path / ".claude" / "commands" / "lws" / "mock.md").read_text()
        assert expected_text in actual_content

    def test_chaos_command_contains_instructions(self, tmp_path):
        # Arrange
        expected_text = "chaos engineering"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        actual_content = (tmp_path / ".claude" / "commands" / "lws" / "chaos.md").read_text()
        assert expected_text in actual_content
