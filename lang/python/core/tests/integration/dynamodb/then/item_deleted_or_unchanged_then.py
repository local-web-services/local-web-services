"""Then: the item is deleted or unchanged (conditional delete)"""

from __future__ import annotations

from pytest_bdd import then


@then("the item is deleted or unchanged (conditional delete)")
def item_deleted_or_unchanged_then(world: dict):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected delete to succeed (item deleted or not present) but got: {actual_error}"
