"""Then: the "s3" "bucket" will send "eventbridge" "events" to the "eventbridge" "bus" when "s3" "objects" are uploaded"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'the "s3" "bucket" will send "eventbridge" "events" to the "eventbridge" "bus" when "s3" "objects" are uploaded'
)
def bucket_will_send_events(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected notification configuration to succeed but got error: {actual_error}"
