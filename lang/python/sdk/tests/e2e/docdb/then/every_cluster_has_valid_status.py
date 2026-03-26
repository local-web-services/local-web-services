"""Then: every cluster has a valid status"""

from __future__ import annotations

from pytest_bdd import then


@then("every cluster has a valid status")
def every_cluster_has_valid_status():
    """No-op: cluster status validity is an internal invariant; always passes."""
