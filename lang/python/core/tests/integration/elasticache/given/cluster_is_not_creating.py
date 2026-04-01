"""Given: the "documentdb" "cluster" was not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "documentdb" "cluster" was not "CREATING"')
def cluster_is_not_creating():
    """No-op: clusters are not in CREATING state by default in lws."""
