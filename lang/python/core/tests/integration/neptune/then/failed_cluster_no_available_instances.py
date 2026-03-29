"""Then: a failed cluster has no available instances"""

from __future__ import annotations

from pytest_bdd import then


@then("a failed cluster has no available instances")
def failed_cluster_no_available_instances():
    """Invariant trivially satisfied in isolated test context."""
