"""Given: the "opensearch" "inbound connection" is not already "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "inbound connection" is not already "DELETING"')
def inbound_connection_not_already_deleting_given():
    """No-op: inbound connections are not in DELETING state by default."""
