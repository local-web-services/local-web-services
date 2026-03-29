"""Then: the part is recorded for the upload"""

from __future__ import annotations

from pytest_bdd import then


@then("the part is recorded for the upload")
def part_is_recorded_for_upload(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected part upload to succeed but got: {actual_error}"
