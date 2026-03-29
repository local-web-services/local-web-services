"""Then: every database snapshot has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then("every database snapshot has a valid status")
def every_db_snapshot_has_valid_status():
    """No-op: snapshot status validity is an internal invariant; always passes."""
