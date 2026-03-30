"""Then: the item is written if the condition holds, otherwise the write is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the item is written if the condition holds, otherwise the write is rejected")
def item_written_if_condition_holds_then(world):
    """Conditional write either succeeds or raises ConditionalCheckFailedException."""
    actual_error = world["error"]
    if actual_error is not None:
        expected_error_code = "ConditionalCheckFailedException"
        actual_error_code = getattr(actual_error, "response", {}).get("Error", {}).get("Code", "")
        assert (
            actual_error_code == expected_error_code
        ), f"Expected ConditionalCheckFailedException or success but got: {actual_error}"
