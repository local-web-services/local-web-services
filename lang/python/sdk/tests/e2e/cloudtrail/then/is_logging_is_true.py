"""Then: IsLogging is true"""

from __future__ import annotations

from pytest_bdd import then


@then("IsLogging is true")
def is_logging_is_true(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected GetTrailStatus result but got None"
    actual_is_logging = actual_result.get("IsLogging")
    assert actual_is_logging is True, f"Expected IsLogging to be True but got {actual_is_logging}"
