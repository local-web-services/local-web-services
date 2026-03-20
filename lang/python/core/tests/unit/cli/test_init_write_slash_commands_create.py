"""Unit tests for _write_slash_commands — creating commands."""

from __future__ import annotations

from lws.cli.init import _write_slash_commands


class TestWriteSlashCommands:
    def test_creates_fake_command(self, tmp_path):
        # Arrange
        expected_file = tmp_path / ".claude" / "commands" / "lws" / "fake.md"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        assert expected_file.exists(), "Expected value to be truthy"

    def test_creates_chaos_command(self, tmp_path):
        # Arrange
        expected_file = tmp_path / ".claude" / "commands" / "lws" / "chaos.md"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        assert expected_file.exists(), "Expected value to be truthy"

    def test_creates_iam_auth_command(self, tmp_path):
        # Arrange
        expected_file = tmp_path / ".claude" / "commands" / "lws" / "iam-auth.md"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        assert expected_file.exists(), "Expected value to be truthy"

    def test_returns_written_paths(self, tmp_path):
        # Arrange
        expected_count = 3

        # Act
        actual_paths = _write_slash_commands(tmp_path)

        # Assert
        assert len(actual_paths) == expected_count, (
            f"Expected {expected_count!r} but got {len(actual_paths)!r}"
        )

    def test_fake_command_contains_instructions(self, tmp_path):
        # Arrange
        expected_text = "AWS operation fakes"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        actual_content = (tmp_path / ".claude" / "commands" / "lws" / "fake.md").read_text()
        assert expected_text in actual_content, (
            f"Expected {expected_text!r} to be in {actual_content!r}"
        )

    def test_chaos_command_contains_instructions(self, tmp_path):
        # Arrange
        expected_text = "chaos engineering"

        # Act
        _write_slash_commands(tmp_path)

        # Assert
        actual_content = (tmp_path / ".claude" / "commands" / "lws" / "chaos.md").read_text()
        assert expected_text in actual_content, (
            f"Expected {expected_text!r} to be in {actual_content!r}"
        )
