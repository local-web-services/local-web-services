"""Given: the "neptune" "cluster" was not "STOPPED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "cluster" was not "STOPPED"')
def cluster_is_not_stopped_given():
    """No-op: clusters are not in STOPPED state by default."""
