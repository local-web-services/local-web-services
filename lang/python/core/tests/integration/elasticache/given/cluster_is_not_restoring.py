"""Given: the cluster is not "RESTORING" """

from __future__ import annotations

from pytest_bdd import given


@given('the cluster is not "RESTORING"')
def cluster_is_not_restoring():
    """No-op: clusters are not in RESTORING state by default."""
