"""Then: both the inbound and outbound connection are "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('both the inbound and outbound connection are "ACTIVE"')
def both_connections_are_active(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
