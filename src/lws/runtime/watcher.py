"""File-system watcher with debouncing for the LDK runtime.

Monitors a directory tree for changes and invokes registered callbacks when
files matching the configured include/exclude patterns are modified, created,
or deleted.  A configurable debounce window prevents callbacks from firing
multiple times during rapid sequences of writes.
"""

from __future__ import annotations

import fnmatch
import logging
import threading
import time
from collections.abc import Callable
from pathlib import Path

from watchdog.events import FileSystemEvent, FileSystemEventHandler
from watchdog.observers import Observer

from lws.logging.logger import get_logger

logger = logging.getLogger(__name__)
_ldk_logger = get_logger("ldk.watcher")


class FileChangeHandler(FileSystemEventHandler):
    """Watchdog event handler that filters events and debounces callbacks.

    Args:
        callback: Invoked with each changed ``Path`` after the debounce window.
        include_patterns: Glob patterns that a path must match to be accepted.
        exclude_patterns: Glob patterns that cause a path to be rejected.
        debounce_seconds: Minimum quiet period before the callback fires.
    """

    def __init__(
        self,
        callback: Callable[[Path], None],
        include_patterns: list[str],
        exclude_patterns: list[str],
        debounce_seconds: float = 0.3,
    ) -> None:
        super().__init__()
        self._callback = callback
        self._include_patterns = include_patterns
        self._exclude_patterns = exclude_patterns
        self._debounce_seconds = debounce_seconds
        self._last_event_time: float = 0.0
        self._pending_paths: set[Path] = set()
        self._timer: threading.Timer | None = None
        self._lock = threading.Lock()

    # ------------------------------------------------------------------
    # Pattern matching
    # ------------------------------------------------------------------

    def _matches(self, path: str) -> bool:
        """Return ``True`` if *path* passes include/exclude filtering.

        A path must match at least one include pattern **and** must not match
        any exclude pattern.
        """
        # Check exclude patterns first – an excluded path is never relevant.
        for pattern in self._exclude_patterns:
            if fnmatch.fnmatch(path, pattern):
                return False

        # If there are no include patterns everything is included by default.
        if not self._include_patterns:
            return True

        for pattern in self._include_patterns:
            if fnmatch.fnmatch(path, pattern):
                return True

        return False

    # ------------------------------------------------------------------
    # Debounced dispatch
    # ------------------------------------------------------------------

    def _schedule_callback(self) -> None:
        """Cancel any pending timer and schedule a new debounced callback."""
        with self._lock:
            if self._timer is not None:
                self._timer.cancel()
            self._timer = threading.Timer(self._debounce_seconds, self._fire)
            self._timer.daemon = True
            self._timer.start()

    def _fire(self) -> None:
        """Invoke the callback for each accumulated pending path."""
        with self._lock:
            paths = list(self._pending_paths)
            self._pending_paths.clear()
            self._timer = None

        if paths:
            _ldk_logger.info("Changed: %s", ", ".join(str(p) for p in paths))

        for p in paths:
            start = time.monotonic()
            try:
                self._callback(p)
                elapsed_ms = (time.monotonic() - start) * 1000
                handler_name = p.stem if p.suffix else p.name
                _ldk_logger.info("Reloaded %s in %0.fms", handler_name, elapsed_ms)
            except Exception:
                _ldk_logger.error("Reload error for %s: see logs for details", p)
                logger.exception("Error in file-change callback for %s", p)

    # ------------------------------------------------------------------
    # FileSystemEventHandler overrides
    # ------------------------------------------------------------------

    def _handle_event(self, event: FileSystemEvent) -> None:
        if event.is_directory:
            return
        src_path: str = event.src_path
        if not self._matches(src_path):
            return

        logger.debug("File event: %s %s", event.event_type, src_path)

        with self._lock:
            self._pending_paths.add(Path(src_path))
            self._last_event_time = time.monotonic()

        self._schedule_callback()

    def on_modified(self, event: FileSystemEvent) -> None:
        self._handle_event(event)

    def on_created(self, event: FileSystemEvent) -> None:
        self._handle_event(event)

    def on_deleted(self, event: FileSystemEvent) -> None:
        self._handle_event(event)


class FileWatcher:
    """Watch a directory for file changes and invoke registered callbacks.

    Args:
        watch_dir: Root directory to watch.
        include_patterns: Glob patterns for files to include.
        exclude_patterns: Glob patterns for files to exclude.
        debounce_seconds: Debounce window passed to the underlying handler.
    """

    def __init__(
        self,
        watch_dir: Path,
        include_patterns: list[str] | None = None,
        exclude_patterns: list[str] | None = None,
        debounce_seconds: float = 0.3,
    ) -> None:
        self._watch_dir = watch_dir
        self._include_patterns = include_patterns or []
        self._exclude_patterns = exclude_patterns or []
        self._debounce_seconds = debounce_seconds
        self._observer: Observer | None = None
        self._callbacks: list[Callable[[Path], None]] = []

    def on_change(self, callback: Callable[[Path], None]) -> None:
        """Register a *callback* to be invoked when a matching file changes."""
        self._callbacks.append(callback)

    # ------------------------------------------------------------------
    # Lifecycle
    # ------------------------------------------------------------------

    def _dispatch(self, path: Path) -> None:
        """Fan-out a change notification to every registered callback."""
        for cb in self._callbacks:
            try:
                cb(path)
            except Exception:
                logger.exception("Error in watcher callback for %s", path)

    def start(self) -> None:
        """Create and start a watchdog ``Observer`` for the configured directory."""
        if self._observer is not None:
            logger.warning("FileWatcher.start() called but observer already running")
            return

        handler = FileChangeHandler(
            callback=self._dispatch,
            include_patterns=self._include_patterns,
            exclude_patterns=self._exclude_patterns,
            debounce_seconds=self._debounce_seconds,
        )

        self._observer = Observer()
        self._observer.schedule(handler, str(self._watch_dir), recursive=True)
        self._observer.start()
        logger.info("FileWatcher started on %s", self._watch_dir)

    def stop(self) -> None:
        """Stop and join the underlying observer thread."""
        if self._observer is None:
            return
        self._observer.stop()
        self._observer.join()
        self._observer = None
        logger.info("FileWatcher stopped")
