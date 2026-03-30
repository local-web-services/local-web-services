"""Given: the session does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the session does not exist")
def session_does_not_exist(world):
    world["session_id"] = "nonexistent-session-id"
