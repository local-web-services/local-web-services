"""Given: an "opensearch" "connection" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('an "opensearch" "connection" "slot" was "available"')
def connection_slot_available():
    """No-op: always room for connections."""
