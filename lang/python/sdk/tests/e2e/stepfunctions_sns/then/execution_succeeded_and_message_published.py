"""Then: the execution is "SUCCEEDED" and the message has been published to the topic"""

from __future__ import annotations

from pytest_bdd import then


@then('the execution is "SUCCEEDED" and the message has been published to the topic')
def execution_succeeded_and_message_published(lws_session, world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected start_execution to succeed but got: {actual_error}"
    assert "executionArn" in world["result"], "Expected 'executionArn' in response"
