"""Then: the bucket will publish notifications to the topic when objects are uploaded"""

from __future__ import annotations

from pytest_bdd import then


@then("the bucket will publish notifications to the topic when objects are uploaded")
def bucket_will_publish_notifications(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected put_bucket_notification_configuration to succeed but got: {actual_error}"
