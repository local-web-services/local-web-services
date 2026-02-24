"""Tests for ldk.runtime.watcher."""

from __future__ import annotations

import tempfile
import time
from pathlib import Path

from lws.runtime.watcher import FileWatcher

# ---------------------------------------------------------------
# _matches() tests
# ---------------------------------------------------------------


# ---------------------------------------------------------------
# Debounce tests
# ---------------------------------------------------------------


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
        # Arrange
        expected_callback_count = 2
        tmpdir = tempfile.mkdtemp()
        watcher = FileWatcher(watch_dir=Path(tmpdir))

        # Act
        watcher.on_change(lambda p: None)
        watcher.on_change(lambda p: None)

        # Assert
        assert len(watcher._callbacks) == expected_callback_count

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
