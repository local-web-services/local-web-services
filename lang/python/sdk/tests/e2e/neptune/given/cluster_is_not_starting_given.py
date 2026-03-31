"""Given: the "neptune" "cluster" was not "STARTING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "neptune" "cluster" was not "STARTING"')
def cluster_is_not_starting_given():
    """No-op: clusters are not in STARTING state by default."""
