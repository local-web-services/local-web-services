"""Then: the execution is "SUCCEEDED" """

from __future__ import annotations

from pytest_bdd import then


@then('the execution is "SUCCEEDED"')
def execution_is_succeeded_then(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"
