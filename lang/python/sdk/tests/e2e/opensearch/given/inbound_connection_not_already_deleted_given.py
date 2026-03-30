"""Given: the inbound connection is not already "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the inbound connection is not already "DELETED"')
def inbound_connection_not_already_deleted_given():
    """No-op: inbound connections are not deleted by default."""
