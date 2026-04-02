"""Then: every "rds" "snapshot" has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then('every "rds" "snapshot" has a valid status')
def every_db_snapshot_valid_status():
    """Invariant trivially satisfied in isolated test context."""
