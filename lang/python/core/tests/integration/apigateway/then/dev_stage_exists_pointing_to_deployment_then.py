"""Then: the dev stage exists pointing to the deployment"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import INT_STAGE_DEV


@then("the dev stage exists pointing to the deployment")
def dev_stage_exists_pointing_to_deployment_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected dev stage creation result but got None"
    expected_field = "stageName"
    assert (
        expected_field in actual_result
    ), f"Expected dev stage result to contain '{expected_field}' but got: {actual_result}"
    expected_stage_name = INT_STAGE_DEV
    actual_stage_name = actual_result[expected_field]
    assert (
        actual_stage_name == expected_stage_name
    ), f"Expected stage name '{expected_stage_name}' but got '{actual_stage_name}'"
