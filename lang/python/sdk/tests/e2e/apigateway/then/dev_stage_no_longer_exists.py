"""Then: the dev stage no longer exists"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_STAGE_DEV


@then("the dev stage no longer exists")
def dev_stage_no_longer_exists(lws_session, world):
    assert (
        world["error"] is None
    ), f"Expected delete_stage for '{TEST_STAGE_DEV}' to succeed but got: {world['error']}"
