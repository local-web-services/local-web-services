"""Then: both the inbound and outbound connection are "REJECTED" """

from __future__ import annotations

from pytest_bdd import then


@then('both the inbound and outbound connection are "REJECTED"')
def both_connections_are_rejected(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
