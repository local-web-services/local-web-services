"""Given: the "elasticache" "replication group" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticache" "replication group" was "AVAILABLE"')
def rg_is_available():
    """No-op: replication groups are AVAILABLE immediately in lws."""
