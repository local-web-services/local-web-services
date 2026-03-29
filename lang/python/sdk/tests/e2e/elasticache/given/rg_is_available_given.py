"""Given: the replication group is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the replication group is "AVAILABLE"')
def rg_is_available_given():
    """No-op: lws returns replication groups as AVAILABLE after creation."""
