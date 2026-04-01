"""Given: the "opensearch" "outbound connection" is not already "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "outbound connection" is not already "DELETING"')
def outbound_connection_not_already_deleting_given():
    """No-op: connections are not in DELETING state by default."""
