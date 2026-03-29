"""Given: the cluster is not "MODIFYING" """

from __future__ import annotations

from pytest_bdd import given


@given('the cluster is not "MODIFYING"')
def cluster_is_not_modifying_given():
    """No-op: clusters are not in MODIFYING state by default."""
