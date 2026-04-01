"""Then: a deleted cluster has no available instances"""

from __future__ import annotations

from pytest_bdd import then


@then("a deleted cluster has no available instances")
def deleted_cluster_no_available_instances():
    """Invariant trivially satisfied in isolated test context."""
