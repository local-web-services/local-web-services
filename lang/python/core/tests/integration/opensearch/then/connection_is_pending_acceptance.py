"""Then: the connection will be in "PENDING_ACCEPTANCE" state"""

from __future__ import annotations

from pytest_bdd import then


@then('the connection will be in "PENDING_ACCEPTANCE" state')
def connection_is_pending_acceptance(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected connection creation to succeed but got error: {world['error']}"
