"""Given: the cluster is not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the cluster is not "DELETING"')
def cluster_is_not_deleting_given():
    """No-op: clusters are not in DELETING state by default."""
