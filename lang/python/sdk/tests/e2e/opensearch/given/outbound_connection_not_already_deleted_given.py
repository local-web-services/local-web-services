"""Given: the "opensearch" "outbound connection" is not already "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "outbound connection" is not already "DELETED"')
def outbound_connection_not_already_deleted_given():
    """No-op: connections are not deleted by default."""
