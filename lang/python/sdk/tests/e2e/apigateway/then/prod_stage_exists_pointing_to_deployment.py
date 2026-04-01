"""Then: the "api gateway" "prod stage" will exist pointing to the "api gateway" "deployment" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_STAGE_PROD


@then('the "api gateway" "prod stage" will exist pointing to the "api gateway" "deployment"')
def prod_stage_exists_pointing_to_deployment(lws_session, world):
    actual_result = world["result"]
    assert actual_result is not None, "Expected stage creation result but got None"
    expected_name = TEST_STAGE_PROD
    actual_name = actual_result.get("stageName", "")
    assert (
        actual_name == expected_name
    ), f"Expected stage name '{expected_name}' but got '{actual_name}'"
