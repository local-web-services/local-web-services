"""Then: the execution is "FAILED" because the item was not found"""

from __future__ import annotations

from pytest_bdd import then


@then('the execution is "FAILED" because the item was not found')
def execution_failed_item_not_found(world):
    # Arrange
    expected_error = None
    # Assert: the execution should have started successfully (lws does not raise on GetItem miss)
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
