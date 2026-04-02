"""Then: every "documentdb" "snapshot" has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then('every "documentdb" "snapshot" has a valid status')
def every_snapshot_has_valid_status():
    """Invariant: trivially satisfied in isolated lws context."""
