"""Then: the "glacier" "upload" part will be recorded"""

from __future__ import annotations

from pytest_bdd import then


@then('the "glacier" "upload" part will be recorded')
def part_is_recorded_for_upload(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected part upload to succeed but got: {actual_error}"
