"""Given: the "sts" "session" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "sts" "session" did not exist')
def the_sts_session_did_not_exist(world):
    world["session_token"] = "lws-nonexistent-token"
    world["session_exists"] = False
