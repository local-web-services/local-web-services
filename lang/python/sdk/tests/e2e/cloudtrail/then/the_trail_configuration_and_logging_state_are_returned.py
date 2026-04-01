"""Then: the trail configuration and logging state are returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TRAIL


@then("the trail configuration and logging state are returned")
def the_trail_configuration_and_logging_state_are_returned(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected GetTrail result but got None"
    actual_name = actual_result["Trail"]["Name"]
    expected_name = TEST_TRAIL
    assert (
        actual_name == expected_name
    ), f"Expected trail name '{expected_name}' but got '{actual_name}'"
