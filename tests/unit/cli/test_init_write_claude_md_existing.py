"""Unit tests for _write_claude_md — appending to existing CLAUDE.md."""

from __future__ import annotations

from lws.cli.init import _write_claude_md


class TestWriteClaudeMdExistingFile:
    def test_preserves_existing_content(self, tmp_path):
        # Arrange
        expected_existing = "# My Project"
        (tmp_path / "CLAUDE.md").write_text(expected_existing)

        # Act
        _write_claude_md(tmp_path)

        # Assert
        actual_content = (tmp_path / "CLAUDE.md").read_text()
        assert expected_existing in actual_content

    def test_appends_lws_block(self, tmp_path):
        # Arrange
        expected_marker = "<!-- LWS:START -->"
        (tmp_path / "CLAUDE.md").write_text("# My Project\n\nExisting content.")

        # Act
        _write_claude_md(tmp_path)

        # Assert
        actual_content = (tmp_path / "CLAUDE.md").read_text()
        assert expected_marker in actual_content
