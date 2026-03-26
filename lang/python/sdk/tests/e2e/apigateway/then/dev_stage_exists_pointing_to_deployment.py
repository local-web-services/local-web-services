"""Then: the dev stage exists pointing to the deployment"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_STAGE_DEV


@then("the dev stage exists pointing to the deployment")
def dev_stage_exists_pointing_to_deployment(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected stage creation result but got None"
    expected_name = TEST_STAGE_DEV
    actual_name = actual_result.get("stageName", "")
    assert (
        actual_name == expected_name
    ), f"Expected stage name '{expected_name}' but got '{actual_name}'"
