"""Tests for ldk.runtime.watcher."""

from __future__ import annotations

import tempfile
import time
from pathlib import Path

from ldk.runtime.watcher import FileChangeHandler, FileWatcher

# ---------------------------------------------------------------
# _matches() tests
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


# ---------------------------------------------------------------
# Debounce tests
# ---------------------------------------------------------------


class TestDebouncing:
    """Tests verifying that rapid changes are debounced into a single callback."""

    def test_rapid_changes_debounced(self) -> None:
        """Multiple file writes within the debounce window should produce one callback per path."""
        tmpdir = tempfile.mkdtemp()
        changed: list[Path] = []

        def on_change(p: Path) -> None:
            changed.append(p)

        watcher = FileWatcher(
            watch_dir=Path(tmpdir),
            include_patterns=[],
            exclude_patterns=[],
            debounce_seconds=0.3,
        )
        watcher.on_change(on_change)
        watcher.start()

        try:
            # Write the same file several times rapidly
            target = Path(tmpdir) / "hello.txt"
            for i in range(5):
                target.write_text(f"change {i}")
                time.sleep(0.05)

            # Wait for debounce to fire
            time.sleep(1.0)

            # We expect the callback to have fired, but not 5 times
            assert len(changed) >= 1
            assert len(changed) < 5
        finally:
            watcher.stop()

    def test_separate_files_each_reported(self) -> None:
        """Changes to distinct files should each be reported after debounce."""
        tmpdir = tempfile.mkdtemp()
        changed: list[Path] = []

        def on_change(p: Path) -> None:
            changed.append(p)

        watcher = FileWatcher(
            watch_dir=Path(tmpdir),
            include_patterns=[],
            exclude_patterns=[],
            debounce_seconds=0.3,
        )
        watcher.on_change(on_change)
        watcher.start()

        try:
            for name in ("a.txt", "b.txt", "c.txt"):
                (Path(tmpdir) / name).write_text("data")
                time.sleep(0.05)

            # Wait for debounce
            time.sleep(1.0)

            reported_names = {p.name for p in changed}
            assert "a.txt" in reported_names
            assert "b.txt" in reported_names
            assert "c.txt" in reported_names
        finally:
            watcher.stop()


# ---------------------------------------------------------------
# Start / Stop lifecycle
# ---------------------------------------------------------------


class TestFileWatcherLifecycle:
    """Tests for FileWatcher start/stop behaviour."""

    def test_start_and_stop(self) -> None:
        """Starting and stopping the watcher should not raise."""
        tmpdir = tempfile.mkdtemp()
        watcher = FileWatcher(
            watch_dir=Path(tmpdir),
            include_patterns=[],
            exclude_patterns=[],
        )
        watcher.start()
        assert watcher._observer is not None
        watcher.stop()
        assert watcher._observer is None

    def test_stop_without_start(self) -> None:
        """Stopping a watcher that was never started should be a no-op."""
        tmpdir = tempfile.mkdtemp()
        watcher = FileWatcher(
            watch_dir=Path(tmpdir),
            include_patterns=[],
            exclude_patterns=[],
        )
        watcher.stop()  # Should not raise

    def test_double_start_is_safe(self) -> None:
        """Calling start() twice should not create a second observer."""
        tmpdir = tempfile.mkdtemp()
        watcher = FileWatcher(
            watch_dir=Path(tmpdir),
            include_patterns=[],
            exclude_patterns=[],
        )
        watcher.start()
        first_observer = watcher._observer
        watcher.start()  # Should be ignored
        assert watcher._observer is first_observer
        watcher.stop()

    def test_on_change_registers_callback(self) -> None:
        """on_change should accumulate callbacks."""
        tmpdir = tempfile.mkdtemp()
        watcher = FileWatcher(watch_dir=Path(tmpdir))
        watcher.on_change(lambda p: None)
        watcher.on_change(lambda p: None)
        assert len(watcher._callbacks) == 2

    def test_callback_receives_events_after_start(self) -> None:
        """A callback registered before start() should receive file events."""
        tmpdir = tempfile.mkdtemp()
        received: list[Path] = []

        watcher = FileWatcher(
            watch_dir=Path(tmpdir),
            include_patterns=[],
            exclude_patterns=[],
            debounce_seconds=0.2,
        )
        watcher.on_change(received.append)
        watcher.start()

        try:
            (Path(tmpdir) / "test.txt").write_text("hello")
            time.sleep(1.0)
            assert len(received) >= 1
        finally:
            watcher.stop()
