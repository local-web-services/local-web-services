"""Given: multi-"AZ" is not enabled for the cluster"""

from __future__ import annotations

from pytest_bdd import given


@given('multi-"AZ" is not enabled for the cluster')
def multi_az_not_enabled():
    """No-op: multi-AZ is not enabled by default in lws."""
