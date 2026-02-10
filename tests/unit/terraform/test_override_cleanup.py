"""Tests for lws.terraform.override -- override file cleanup."""

from __future__ import annotations

from pathlib import Path

from lws.terraform.override import MARKER_COMMENT, OVERRIDE_FILENAME, cleanup_override


class TestCleanupOverride:
    """Tests for the cleanup_override function."""

    def test_removes_lws_generated_file(self, tmp_path: Path) -> None:
        """Remove LWS-generated override file."""
        override_path = tmp_path / OVERRIDE_FILENAME
        override_path.write_text(f'{MARKER_COMMENT}\nprovider "aws" {{}}')

        cleanup_override(tmp_path)

        assert not override_path.exists()

    def test_ignores_user_file(self, tmp_path: Path) -> None:
        """Do not remove user-created override file."""
        override_path = tmp_path / OVERRIDE_FILENAME
        user_content = '# User-created file\nprovider "aws" {}'
        override_path.write_text(user_content)

        cleanup_override(tmp_path)

        assert override_path.exists()
        assert override_path.read_text() == user_content

    def test_handles_missing_file(self, tmp_path: Path) -> None:
        """Handle missing override file without error."""
        cleanup_override(tmp_path)

        # Should not raise any exception
        assert not (tmp_path / OVERRIDE_FILENAME).exists()
