"""Unit tests for _write_claude_md — creating a new CLAUDE.md."""

from __future__ import annotations

from lws.cli.init import _write_claude_md


class TestWriteClaudeMdNewFile:
    def test_creates_file_when_missing(self, tmp_path):
        # Arrange
        expected_marker = "<!-- LWS:START -->"

        # Act
        result = _write_claude_md(tmp_path)

        # Assert
        actual_content = result.read_text()
        assert expected_marker in actual_content

    def test_contains_lws_section(self, tmp_path):
        # Arrange
        expected_heading = "# Local Web Services (LWS)"

        # Act
        _write_claude_md(tmp_path)

        # Assert
        actual_content = (tmp_path / "CLAUDE.md").read_text()
        assert expected_heading in actual_content
