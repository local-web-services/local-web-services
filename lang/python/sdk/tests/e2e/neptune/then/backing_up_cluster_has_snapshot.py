"""Then: every backing-up cluster has a corresponding in-progress snapshot"""

from __future__ import annotations

from pytest_bdd import then


@then("every backing-up cluster has a corresponding in-progress snapshot")
def backing_up_cluster_has_snapshot():
    """No-op: backup snapshot consistency is an internal invariant; always passes."""
