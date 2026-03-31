"""Then: the "dynamodb" "item" will be "DELETED" or unchanged (conditional delete)"""

from __future__ import annotations

from pytest_bdd import then


@then('the "dynamodb" "item" will be "DELETED" or unchanged (conditional delete)')
def item_deleted_or_unchanged_then(lws_session, world):
    """After a delete attempt, the item is either gone or was never there."""
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected delete to succeed (item deleted or not present) but got: {actual_error}"
