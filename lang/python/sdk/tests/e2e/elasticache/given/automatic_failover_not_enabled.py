"""Given: automatic failover was not "ENABLED" """

from __future__ import annotations

from pytest_bdd import given


@given('automatic failover was not "ENABLED"')
def automatic_failover_not_enabled():
    """No-op: automatic failover is not enabled by default."""
