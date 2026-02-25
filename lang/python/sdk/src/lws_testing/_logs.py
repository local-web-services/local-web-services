"""Log capture utilities for LWS testing sessions."""

from __future__ import annotations

import time
from typing import Any


class LogCapture:
    """Captures log entries emitted during a code block.

    Use via :meth:`~lws_testing.LwsSession.capture_logs`::

        with session.capture_logs() as logs:
            my_service.create_order(...)

        logs.assert_called("dynamodb", "PutItem")
        logs.assert_no_errors()
    """

    def __init__(self, log_handler: Any) -> None:
        self._handler = log_handler
        self._entries: list[dict[str, Any]] = []
        self._snapshot_len: int = 0

    def start(self) -> None:
        """Record the current log buffer length so we can slice new entries."""
        if self._handler is None:
            return
        self._snapshot_len = len(self._handler.backlog())

    def stop(self) -> None:
        """Collect all entries appended since :meth:`start` was called."""
        if self._handler is None:
            return
        # Allow background log handler to flush async log entries.
        time.sleep(0.2)
        full_backlog = self._handler.backlog()
        self._entries = full_backlog[self._snapshot_len :]

    # ── Access ────────────────────────────────────────────────────────────────

    @property
    def entries(self) -> list[dict[str, Any]]:
        """All log entries captured in this window."""
        return list(self._entries)

    def for_service(self, service: str) -> list[dict[str, Any]]:
        """Return entries for a specific AWS service (e.g. ``"dynamodb"``)."""
        service_lower = service.lower()
        return [e for e in self._entries if e.get("service", "").lower() == service_lower]

    def for_operation(self, operation: str) -> list[dict[str, Any]]:
        """Return entries for a specific operation (e.g. ``"PutItem"``)."""
        return [e for e in self._entries if e.get("operation") == operation]

    # ── Assertions ────────────────────────────────────────────────────────────

    def assert_called(self, service: str, operation: str) -> None:
        """Assert that *service*.*operation* was called at least once."""
        expected_service = service.lower()
        matching = [
            e
            for e in self._entries
            if e.get("service", "").lower() == expected_service and e.get("operation") == operation
        ]
        assert matching, (
            f"Expected {service}.{operation} to have been called, "
            f"but no matching log entry was found. "
            f"Captured entries: {self._entries}"
        )

    def assert_not_called(self, service: str, operation: str) -> None:
        """Assert that *service*.*operation* was NOT called."""
        expected_service = service.lower()
        matching = [
            e
            for e in self._entries
            if e.get("service", "").lower() == expected_service and e.get("operation") == operation
        ]
        assert not matching, (
            f"Expected {service}.{operation} NOT to have been called, "
            f"but found {len(matching)} matching log entry/entries."
        )

    def assert_no_errors(self) -> None:
        """Assert that no ERROR-level log entries were captured."""
        errors = [e for e in self._entries if e.get("level") == "ERROR"]
        assert not errors, f"Expected no ERROR log entries, but found {len(errors)}: {errors}"

    def assert_call_count(self, service: str, operation: str, expected_count: int) -> None:
        """Assert that *service*.*operation* was called exactly *expected_count* times."""
        expected_service = service.lower()
        actual_entries = [
            e
            for e in self._entries
            if e.get("service", "").lower() == expected_service and e.get("operation") == operation
        ]
        actual_count = len(actual_entries)
        assert actual_count == expected_count, (
            f"Expected {service}.{operation} to be called {expected_count} time(s), "
            f"but was called {actual_count} time(s)."
        )
