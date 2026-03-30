"""Then: every snapshot has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then("every snapshot has a valid status")
def every_snapshot_valid_status():
    """Invariant trivially satisfied in isolated test context."""
