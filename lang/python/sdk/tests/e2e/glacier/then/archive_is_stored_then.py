"""Then: the archive is "STORED" and the vault archive count increases"""

from __future__ import annotations

from pytest_bdd import then


@then('the archive is "STORED" and the vault archive count increases')
def archive_is_stored_then(world):
    expected_error = None
    actual_error = world["error"]
    assert (
        actual_error is expected_error
    ), f"Expected archive upload to succeed but got: {actual_error}"
    actual_result = world["result"]
    expected_field = "archiveId"
    assert (
        actual_result is not None and expected_field in actual_result
    ), f"Expected archiveId in result but got: {actual_result}"
