"""Then: the instance is "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the instance is "DELETED"')
def instance_is_deleted(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
