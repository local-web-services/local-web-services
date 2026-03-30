"""Given: the cluster is not "STOPPED" """

from __future__ import annotations

from pytest_bdd import given


@given('the cluster is not "STOPPED"')
def cluster_is_not_stopped_given():
    """No-op: clusters are not in STOPPED state by default."""
