"""Given: the "opensearch" "inbound connection" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "inbound connection" was not "DELETING"')
def inbound_connection_is_not_deleting_given():
    """No-op: inbound connections are not in DELETING state by default."""
