"""Then: the state machine will write an item to the "dynamodb" "table" when it reaches the task state"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the state machine will write an item to the "dynamodb" "table" when it reaches the task state'
)
def sm_will_write_item(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected state machine update to succeed but got: {actual_error}"
