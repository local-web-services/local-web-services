"""Then: the "dynamodb" "item" will be written if the condition holds, otherwise the write will be rejected"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "dynamodb" "item" will be written if the condition holds, otherwise the write will be rejected'
)
def item_written_if_condition_holds_then(world: dict):
    actual_error = world["error"]
    if actual_error is not None:
        expected_error_type = "ConditionalCheckFailedException"
        actual_error_type = actual_error.get("__type", "") if isinstance(actual_error, dict) else ""
        assert (
            expected_error_type in actual_error_type
        ), f"Expected ConditionalCheckFailedException or success but got: {actual_error}"
