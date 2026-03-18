"""Tests for lws.terraform.gitignore -- .gitignore management."""

from __future__ import annotations

from pathlib import Path

from lws.terraform.gitignore import ensure_gitignore
from lws.terraform.override import OVERRIDE_FILENAME


class TestEnsureGitignore:
    """Tests for the ensure_gitignore function."""

    def test_creates_gitignore_when_missing(self, tmp_path: Path) -> None:
        """Create .gitignore with override entry when it does not exist."""
        # Arrange
        gitignore_path = tmp_path / ".gitignore"
        assert not gitignore_path.exists()

        # Act
        ensure_gitignore(tmp_path)

        # Assert
        assert gitignore_path.exists()
        actual_content = gitignore_path.read_text()
        assert OVERRIDE_FILENAME in actual_content
        assert actual_content.endswith("\n")

    def test_appends_to_existing_gitignore(self, tmp_path: Path) -> None:
        """Append override entry to existing .gitignore."""
        # Arrange
        gitignore_path = tmp_path / ".gitignore"
        existing_content = "node_modules/\n*.pyc\n"
        gitignore_path.write_text(existing_content)

        # Act
        ensure_gitignore(tmp_path)

        # Assert
        actual_content = gitignore_path.read_text()
        assert "node_modules/" in actual_content
        assert "*.pyc" in actual_content
        assert OVERRIDE_FILENAME in actual_content
        assert actual_content.endswith("\n")

    def test_skips_when_already_present(self, tmp_path: Path) -> None:
        """Skip modification when override entry is already in .gitignore."""
        # Arrange
        gitignore_path = tmp_path / ".gitignore"
        expected_content = f"node_modules/\n{OVERRIDE_FILENAME}\n*.pyc\n"
        gitignore_path.write_text(expected_content)

        # Act
        ensure_gitignore(tmp_path)

        # Assert
        actual_content = gitignore_path.read_text()
        assert actual_content == expected_content
