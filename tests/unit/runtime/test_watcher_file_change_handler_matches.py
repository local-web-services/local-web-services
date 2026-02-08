"""Tests for ldk.runtime.watcher."""

from __future__ import annotations

from ldk.runtime.watcher import FileChangeHandler

# ---------------------------------------------------------------
# _matches() tests
# ---------------------------------------------------------------


# ---------------------------------------------------------------
# Debounce tests
# ---------------------------------------------------------------


# ---------------------------------------------------------------
# Start / Stop lifecycle
# ---------------------------------------------------------------


class TestFileChangeHandlerMatches:
    """Unit tests for FileChangeHandler._matches()."""

    def test_include_pattern_matches(self) -> None:
        """A path matching an include pattern should be accepted."""
        handler = FileChangeHandler(
            callback=lambda p: None,
            include_patterns=["src/*"],
            exclude_patterns=[],
        )
        assert handler._matches("src/main.py") is True

    def test_include_pattern_does_not_match(self) -> None:
        """A path that does not match any include pattern should be rejected."""
        handler = FileChangeHandler(
            callback=lambda p: None,
            include_patterns=["src/*"],
            exclude_patterns=[],
        )
        assert handler._matches("docs/readme.md") is False

    def test_exclude_pattern_rejects(self) -> None:
        """A path matching an exclude pattern should be rejected even if it matches include."""
        handler = FileChangeHandler(
            callback=lambda p: None,
            include_patterns=["*"],
            exclude_patterns=["node_modules/*"],
        )
        # fnmatch "node_modules/*" matches one level deep
        assert handler._matches("node_modules/index.js") is False

    def test_exclude_node_modules(self) -> None:
        """Paths under node_modules should be excluded."""
        handler = FileChangeHandler(
            callback=lambda p: None,
            include_patterns=["*"],
            exclude_patterns=["node_modules*"],
        )
        assert handler._matches("node_modules/pkg/index.js") is False

    def test_exclude_git_directory(self) -> None:
        """Paths under .git should be excluded."""
        handler = FileChangeHandler(
            callback=lambda p: None,
            include_patterns=["*"],
            exclude_patterns=[".git*"],
        )
        assert handler._matches(".git/config") is False

    def test_no_include_patterns_accepts_all(self) -> None:
        """When no include patterns are provided, all non-excluded paths should match."""
        handler = FileChangeHandler(
            callback=lambda p: None,
            include_patterns=[],
            exclude_patterns=[],
        )
        assert handler._matches("anything/goes.txt") is True

    def test_multiple_include_patterns(self) -> None:
        """A path matching any of several include patterns should be accepted."""
        handler = FileChangeHandler(
            callback=lambda p: None,
            include_patterns=["src/*", "lib/*"],
            exclude_patterns=[],
        )
        assert handler._matches("src/app.py") is True
        assert handler._matches("lib/utils.py") is True
        assert handler._matches("test/test_app.py") is False

    def test_exclude_takes_precedence(self) -> None:
        """Exclude patterns should override include patterns."""
        handler = FileChangeHandler(
            callback=lambda p: None,
            include_patterns=["*.py"],
            exclude_patterns=["test_*.py"],
        )
        assert handler._matches("main.py") is True
        assert handler._matches("test_main.py") is False
