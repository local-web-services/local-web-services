"""Given: multi-"AZ" was not "ENABLED" for the "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import given


@given('multi-"AZ" was not "ENABLED" for the "neptune" "cluster"')
@given('multi-"AZ" was not "ENABLED" for the "memorydb" "cluster"')
def multi_az_not_enabled_for_cluster():
    """No-op: clusters have no multi-AZ in lws by default."""
