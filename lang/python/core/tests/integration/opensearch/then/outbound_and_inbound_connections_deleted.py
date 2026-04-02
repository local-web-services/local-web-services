"""Then: the "opensearch" "outbound connection" and associated "opensearch" "inbound connection" will be "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "opensearch" "outbound connection" and associated "opensearch" "inbound connection" will be "DELETED"'
)
def outbound_and_inbound_connections_deleted(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
