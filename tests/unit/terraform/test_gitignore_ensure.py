"""Tests for lws.terraform.gitignore -- .gitignore management."""

from __future__ import annotations

from pathlib import Path

from lws.terraform.gitignore import ensure_gitignore
from lws.terraform.override import OVERRIDE_FILENAME


class TestEnsureGitignore:
    """Tests for the ensure_gitignore function."""

    def test_creates_gitignore_when_missing(self, tmp_path: Path) -> None:
        """Create .gitignore with override entry when it does not exist."""
        gitignore_path = tmp_path / ".gitignore"
        assert not gitignore_path.exists()

        ensure_gitignore(tmp_path)

        assert gitignore_path.exists()
        content = gitignore_path.read_text()
        assert OVERRIDE_FILENAME in content
        assert content.endswith("\n")

    def test_appends_to_existing_gitignore(self, tmp_path: Path) -> None:
        """Append override entry to existing .gitignore."""
        gitignore_path = tmp_path / ".gitignore"
        existing_content = "node_modules/\n*.pyc\n"
        gitignore_path.write_text(existing_content)

        ensure_gitignore(tmp_path)

        content = gitignore_path.read_text()
        assert "node_modules/" in content
        assert "*.pyc" in content
        assert OVERRIDE_FILENAME in content
        assert content.endswith("\n")

    def test_skips_when_already_present(self, tmp_path: Path) -> None:
        """Skip modification when override entry is already in .gitignore."""
        gitignore_path = tmp_path / ".gitignore"
        original_content = f"node_modules/\n{OVERRIDE_FILENAME}\n*.pyc\n"
        gitignore_path.write_text(original_content)

        ensure_gitignore(tmp_path)

        # Content should remain unchanged
        assert gitignore_path.read_text() == original_content
