"""Given: the outbound connection is not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the outbound connection is not "DELETING"')
def outbound_connection_is_not_deleting_given():
    """No-op: outbound connections are not in DELETING state by default."""
