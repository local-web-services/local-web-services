"""Then: the part is uploaded and the upload is still in progress"""

from __future__ import annotations

from pytest_bdd import then


@then("the part is uploaded and the upload is still in progress")
def part_uploaded_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected part upload to succeed but got: {actual_error}"
