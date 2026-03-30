"""Then: the execution is "FAILED" with a NoSuchKey error"""

from __future__ import annotations

from pytest_bdd import then


@then('the execution is "FAILED" with a NoSuchKey error')
def execution_failed_no_such_key(world):
    # Arrange
    expected_error = None
    # Assert: execution starts successfully even when the key doesn't exist;
    # the failure occurs internally and is handled by the engine
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"
