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
