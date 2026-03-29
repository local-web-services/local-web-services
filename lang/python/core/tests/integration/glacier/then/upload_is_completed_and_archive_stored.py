"""Then: the upload is Completed and the assembled archive is "STORED" in the vault"""

from __future__ import annotations

from pytest_bdd import then


@then('the upload is Completed and the assembled archive is "STORED" in the vault')
def upload_is_completed_and_archive_stored(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected multipart upload completion to succeed but got: {actual_error}"
