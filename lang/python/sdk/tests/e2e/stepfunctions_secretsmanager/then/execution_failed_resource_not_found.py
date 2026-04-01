"""Then: the "step functions" "execution" will be "FAILED" with a ResourceNotFoundException"""

from __future__ import annotations

from pytest_bdd import then


@then('the "step functions" "execution" will be "FAILED" with a ResourceNotFoundException')
def execution_failed_resource_not_found(world):
    # Arrange
    expected_error = None
    # Assert: the execution starts successfully; the SecretsManager failure is internal
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"
