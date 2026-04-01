"""Then: the operation is rejected"""

from __future__ import annotations

from pytest_bdd import then


@then("the operation is rejected")
def operation_is_rejected_lambda_sqs(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world.get("error")
    assert actual_error is not expected_error, "Expected operation to be rejected but it succeeded"
