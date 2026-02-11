"""Tests for lws.terraform.override -- override file cleanup."""

from __future__ import annotations

from pathlib import Path

from lws.terraform.override import MARKER_COMMENT, OVERRIDE_FILENAME, cleanup_override


class TestCleanupOverride:
    """Tests for the cleanup_override function."""

    def test_removes_lws_generated_file(self, tmp_path: Path) -> None:
        """Remove LWS-generated override file."""
        # Arrange
        override_path = tmp_path / OVERRIDE_FILENAME
        override_path.write_text(f'{MARKER_COMMENT}\nprovider "aws" {{}}')

        # Act
        cleanup_override(tmp_path)

        # Assert
        assert not override_path.exists()

    def test_ignores_user_file(self, tmp_path: Path) -> None:
        """Do not remove user-created override file."""
        # Arrange
        override_path = tmp_path / OVERRIDE_FILENAME
        expected_content = '# User-created file\nprovider "aws" {}'
        override_path.write_text(expected_content)

        # Act
        cleanup_override(tmp_path)

        # Assert
        assert override_path.exists()
        actual_content = override_path.read_text()
        assert actual_content == expected_content

    def test_handles_missing_file(self, tmp_path: Path) -> None:
        """Handle missing override file without error."""
        # Act
        cleanup_override(tmp_path)

        # Assert -- should not raise any exception
        assert not (tmp_path / OVERRIDE_FILENAME).exists()
