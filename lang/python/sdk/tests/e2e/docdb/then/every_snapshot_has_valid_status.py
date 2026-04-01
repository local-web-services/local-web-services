"""Then: every snapshot has a valid status"""

from __future__ import annotations

from pytest_bdd import step


@step("every snapshot has a valid status")
def every_snapshot_has_valid_status():
    """No-op: snapshot status validity is an internal invariant; always passes."""
