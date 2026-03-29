"""Then: the upload is "ABORTED" """

from __future__ import annotations

from pytest_bdd import then


@then('the upload is "ABORTED"')
def upload_aborted_then(world):
    assert world["error"] is None, f"Expected abort to succeed but got: {world['error']}"
