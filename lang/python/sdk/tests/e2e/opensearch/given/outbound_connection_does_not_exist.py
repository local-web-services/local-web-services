"""Given: the outbound connection does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the outbound connection does not exist")
def outbound_connection_does_not_exist():
    """No-op: fresh state has no connections."""
