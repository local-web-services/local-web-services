"""Given: the "documentdb" "cluster" will be "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "memorydb" "cluster" was "AVAILABLE"')
@given('the "documentdb" "cluster" will be "AVAILABLE"')
def cluster_is_available():
    """No-op: clusters are AVAILABLE immediately after creation in lws."""
