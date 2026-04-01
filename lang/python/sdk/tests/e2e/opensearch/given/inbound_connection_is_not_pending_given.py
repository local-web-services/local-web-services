"""Given: the "opensearch" "inbound connection" was not "PENDING_ACCEPTANCE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "inbound connection" was not "PENDING_ACCEPTANCE"')
def inbound_connection_is_not_pending_given():
    """No-op: inbound connections are not in PENDING_ACCEPTANCE state by default."""
