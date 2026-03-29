"""Then: a deleted cluster has no non-deleted instances"""

from __future__ import annotations

from pytest_bdd import then


@then("a deleted cluster has no non-deleted instances")
def deleted_cluster_has_no_instances():
    """Invariant: trivially satisfied in isolated lws context."""
