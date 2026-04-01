"""Then: the "glacier" "upload" will be "InProgress" """

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "upload" will be "InProgress"')
def upload_is_in_progress_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected multipart upload initiation to succeed but got: {actual_error}"
    actual_result = world["result"]
    expected_field = "uploadId"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected uploadId in result but got: {actual_result}"
