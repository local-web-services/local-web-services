"""Given: multi-"AZ" was not "ENABLED" for the "memorydb" "cluster" """

from __future__ import annotations

from pytest_bdd import given


@given('multi-"AZ" was not "ENABLED" for the "memorydb" "cluster"')
def multi_az_not_enabled_given():
    """No-op: multi-AZ is not enabled by default."""
