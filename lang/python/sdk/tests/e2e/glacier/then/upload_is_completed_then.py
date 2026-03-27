"""Then: the upload is Completed and the assembled archive is "STORED" in the vault"""

from __future__ import annotations

from pytest_bdd import then


@then('the upload is Completed and the assembled archive is "STORED" in the vault')
def upload_is_completed_then(world):
    expected_error = None
    actual_error = world.get("error")
    assert (
        actual_error is expected_error
    ), f"Expected multipart upload completion to succeed but got: {actual_error}"
    actual_result = world.get("result")
    expected_field = "archiveId"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected archiveId in result but got: {actual_result}"
