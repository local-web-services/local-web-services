"""Given: the inbound connection does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the inbound connection does not exist")
def inbound_connection_does_not_exist():
    """No-op: fresh state has no inbound connections."""
