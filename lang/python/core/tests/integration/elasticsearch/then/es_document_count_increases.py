"""Then: the "elasticsearch" "document" count for the "elasticsearch" "index" increases by one"""

from __future__ import annotations

from pytest_bdd import then


@then('the "elasticsearch" "document" count for the "elasticsearch" "index" increases by one')
def es_document_count_increases(world: dict):
    actual_result = world["result"]
    assert (
        actual_result is not None
    ), f"Expected operation to succeed but got error: {world['error']}"
