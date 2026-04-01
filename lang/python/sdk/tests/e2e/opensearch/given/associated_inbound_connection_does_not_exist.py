"""Given: the associated "opensearch" "inbound connection" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the associated "opensearch" "inbound connection" did not exist')
def associated_inbound_connection_does_not_exist():
    """No-op: no associated inbound connection by default."""
