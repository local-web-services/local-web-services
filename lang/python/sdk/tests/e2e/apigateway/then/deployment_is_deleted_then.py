"""Then: the "api gateway" "deployment" will be deleted"""

from __future__ import annotations

from pytest_bdd import then


@then('the "api gateway" "deployment" will be deleted')
def deployment_is_deleted_then(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected delete_deployment to succeed but got: {world['error']}"
