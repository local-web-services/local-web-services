"""Then: the upload has at least one part"""

from __future__ import annotations

from pytest_bdd import then


@then("the upload has at least one part")
def upload_has_at_least_one_part_then(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected part upload to succeed but got: {actual_error}"
