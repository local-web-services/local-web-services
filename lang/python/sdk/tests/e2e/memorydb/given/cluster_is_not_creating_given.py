"""Given: the cluster is not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the cluster is not "CREATING"')
def cluster_is_not_creating_given():
    """No-op: clusters are not in CREATING state by default."""
