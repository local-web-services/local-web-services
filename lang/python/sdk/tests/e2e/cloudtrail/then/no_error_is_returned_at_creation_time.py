"""Then: no error is returned at creation time"""

from __future__ import annotations

from pytest_bdd import then


@then("no error is returned at creation time")
def no_error_is_returned_at_creation_time(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected no error at creation time but got: {actual_error}"
