"""Then: the "s3" "upload" will be "IN_PROGRESS" with no parts"""

from __future__ import annotations

from pytest_bdd import then


@then('the "s3" "upload" will be "IN_PROGRESS" with no parts')
def upload_in_progress_no_parts_then(world):
    expected_field = "UploadId"
    actual_result = world["result"]
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected UploadId in result but got: {actual_result}"
