"""Given: the "neptune" "cluster" has no non-deleted instances"""

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "cluster" has no non-deleted instances')
def cluster_has_no_non_deleted_instances():
    """No-op: fresh cluster has no instances."""
