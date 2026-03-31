"""Then: the "s3" "upload" will be "ABORTED" """

from __future__ import annotations

from pytest_bdd import then


@then('the "s3" "upload" will be "ABORTED"')
def upload_aborted_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected abort to succeed but got: {actual_error}"
