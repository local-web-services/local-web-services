"""Then: the upload is InProgress"""

from __future__ import annotations

from pytest_bdd import then


@then("the upload is InProgress")
def upload_is_in_progress_then(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected multipart upload initiation to succeed but got: {actual_error}"
