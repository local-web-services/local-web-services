"""Given: multi-"AZ" is not enabled for the cluster"""

from __future__ import annotations

from pytest_bdd import given


@given('multi-"AZ" is not enabled for the cluster')
def multi_az_not_enabled_for_cluster():
    """No-op: clusters have no multi-AZ in lws by default."""
