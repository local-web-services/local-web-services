"""Unit tests for _write_claude_md — idempotent updates."""

from __future__ import annotations

from lws.cli.init import _write_claude_md


class TestWriteClaudeMdIdempotent:
    def test_replaces_existing_lws_block(self, tmp_path):
        # Arrange
        expected_marker_count = 1

        # Act
        _write_claude_md(tmp_path)
        _write_claude_md(tmp_path)

        # Assert
        actual_content = (tmp_path / "CLAUDE.md").read_text()
        actual_marker_count = actual_content.count("<!-- LWS:START -->")
        assert actual_marker_count == expected_marker_count

    def test_preserves_content_outside_markers(self, tmp_path):
        # Arrange
        expected_before = "# Before"
        expected_after = "# After"
        initial = (
            f"{expected_before}\n\n"
            "<!-- LWS:START -->\nold content\n<!-- LWS:END -->\n\n"
            f"{expected_after}\n"
        )
        (tmp_path / "CLAUDE.md").write_text(initial)

        # Act
        _write_claude_md(tmp_path)

        # Assert
        actual_content = (tmp_path / "CLAUDE.md").read_text()
        assert expected_before in actual_content
        assert expected_after in actual_content
