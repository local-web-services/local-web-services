"""Given: the replication group is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the replication group is "AVAILABLE"')
def rg_is_available():
    """No-op: replication groups are AVAILABLE immediately in lws."""
