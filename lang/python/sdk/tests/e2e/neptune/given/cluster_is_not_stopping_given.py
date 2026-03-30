"""Given: the cluster is not "STOPPING" """

from __future__ import annotations

from pytest_bdd import given


@given('the cluster is not "STOPPING"')
def cluster_is_not_stopping_given():
    """No-op: clusters are not in STOPPING state by default."""
