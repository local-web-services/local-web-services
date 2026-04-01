"""Then: both trails are included in the response"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TRAIL, TEST_TRAIL_2


@then("both trails are included in the response")
def both_trails_are_included_in_the_response(world):
    actual_result = world.get("result")
    assert actual_result is not None, "Expected ListTrails result but got None"
    actual_trails = actual_result.get("Trails", [])
    actual_names = {t.get("Name") or t.get("TrailARN", "") for t in actual_trails}
    expected_trail_1 = TEST_TRAIL
    expected_trail_2 = TEST_TRAIL_2
    assert any(
        expected_trail_1 in n for n in actual_names
    ), f"Expected trail '{expected_trail_1}' in response but got: {actual_names}"
    assert any(
        expected_trail_2 in n for n in actual_names
    ), f"Expected trail '{expected_trail_2}' in response but got: {actual_names}"
