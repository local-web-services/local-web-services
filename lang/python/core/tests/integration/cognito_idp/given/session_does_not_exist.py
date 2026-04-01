"""Given: the "cognito" "session" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "cognito" "session" did not exist')
def session_does_not_exist(world):
    world["session_id"] = "nonexistent-session-id"
