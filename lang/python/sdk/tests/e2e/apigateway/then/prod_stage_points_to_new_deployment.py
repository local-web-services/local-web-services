"""Then: the "api gateway" "prod stage" points to the new deployment"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_STAGE_PROD


@then('the "api gateway" "prod stage" points to the new deployment')
def prod_stage_points_to_new_deployment(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected update_stage for '{TEST_STAGE_PROD}' to succeed but got: {world['error']}"
