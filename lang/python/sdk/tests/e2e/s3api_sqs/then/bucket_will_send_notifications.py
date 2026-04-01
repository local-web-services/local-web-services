"""Then: the bucket will send notifications to the queue when objects are uploaded"""

from __future__ import annotations

from pytest_bdd import then


@then("the bucket will send notifications to the queue when objects are uploaded")
def bucket_will_send_notifications(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected put_bucket_notification_configuration to succeed but got: {actual_error}"
