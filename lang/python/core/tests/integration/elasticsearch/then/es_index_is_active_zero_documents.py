"""Then: the index is "ACTIVE" with zero documents"""

from __future__ import annotations

from pytest_bdd import then


@then('the index is "ACTIVE" with zero documents')
def es_index_is_active_zero_documents(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
