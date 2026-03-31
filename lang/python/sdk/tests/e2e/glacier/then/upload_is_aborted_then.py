"""Then: the "glacier" "upload" will be "Aborted" """

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "upload" will be "Aborted"')
def upload_is_aborted_then(world):
    expected_error = None
    actual_error = world.get("error")
    assert (
        actual_error is expected_error
    ), f"Expected multipart upload abort to succeed but got: {actual_error}"
