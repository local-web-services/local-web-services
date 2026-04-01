"""Given: the "memorydb" "cluster" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "cluster" was "AVAILABLE"')
def cluster_is_available_given():
    """No-op: lws returns clusters as AVAILABLE immediately after creation."""
