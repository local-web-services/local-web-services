"""Then: the "glacier" "upload" will be "Aborted" """

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "upload" will be "Aborted"')
def upload_is_aborted(world):
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected multipart upload abort to succeed but got: {actual_error}"
