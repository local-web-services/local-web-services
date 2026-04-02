"""Then: the "glacier" "upload" part will be recorded"""

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "upload" part will be recorded')
def part_is_recorded_then(world):
    expected_error = None
    actual_error = world.get("error")
    assert (
        actual_error is expected_error
    ), f"Expected part upload to succeed but got: {actual_error}"
    expected_part_uploaded = True
    actual_part_uploaded = world.get("part_uploaded")
    assert (
        actual_part_uploaded == expected_part_uploaded
    ), f"Expected part_uploaded={expected_part_uploaded!r} but got: {actual_part_uploaded!r}"
