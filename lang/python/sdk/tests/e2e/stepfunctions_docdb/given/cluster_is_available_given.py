"""Given: the cluster is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the cluster is "AVAILABLE"')
def cluster_is_available_given():
    """No-op: DocumentDB clusters are AVAILABLE immediately after creation."""
