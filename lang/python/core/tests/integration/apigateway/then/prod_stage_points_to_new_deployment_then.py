"""Then: the prod stage points to the new deployment"""

from __future__ import annotations

from pytest_bdd import then


@then("the prod stage points to the new deployment")
def prod_stage_points_to_new_deployment_then(world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected redeploy result but got None"
    expected_field = "deploymentId"
    assert (
        expected_field in actual_result
    ), f"Expected redeployed stage result to contain '{expected_field}' but got: {actual_result}"
