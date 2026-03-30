"""Given: the state machine does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the state machine does not exist")
def sm_does_not_exist(world):
    world["result"] = None
    world["error"] = None
