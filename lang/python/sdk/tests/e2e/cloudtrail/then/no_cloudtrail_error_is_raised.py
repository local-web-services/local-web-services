"""Then: no cloudtrail error is raised"""

from __future__ import annotations

from pytest_bdd import then


@then("no cloudtrail error is raised")
def no_cloudtrail_error_is_raised(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected no CloudTrail error but got: {actual_error}"
