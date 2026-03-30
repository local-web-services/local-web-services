"""Given: the cluster does not exist or is not "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the cluster does not exist or is not "AVAILABLE"')
def cluster_not_exist_or_not_available():
    """No-op: fresh state has no clusters."""
