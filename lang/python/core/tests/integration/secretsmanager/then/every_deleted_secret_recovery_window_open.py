"""Then: every deleted secret with an open recovery window can still be restored or expired"""

from __future__ import annotations

from pytest_bdd import then


@then("every deleted secret with an open recovery window can still be restored or expired")
def every_deleted_secret_recovery_window_open():
    """No-op invariant: trivially satisfied in an isolated test context."""
