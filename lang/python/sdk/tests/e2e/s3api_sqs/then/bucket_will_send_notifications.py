"""Then: the "s3" "bucket" will send "sqs" notifications to the "sqs" "queue" when "s3" "objects" are uploaded"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "s3" "bucket" will send "sqs" notifications to the "sqs" "queue" when "s3" "objects" are uploaded'
)
def bucket_will_send_notifications(world):
    # Arrange
    expected_error = None
    # Assert
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected put_bucket_notification_configuration to succeed but got: {actual_error}"
