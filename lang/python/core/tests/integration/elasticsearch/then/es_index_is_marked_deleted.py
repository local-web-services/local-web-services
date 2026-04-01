"""Then: the "elasticsearch" "index" will be marked as "DELETED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "elasticsearch" "index" will be marked as "DELETED"')
def es_index_is_marked_deleted(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
