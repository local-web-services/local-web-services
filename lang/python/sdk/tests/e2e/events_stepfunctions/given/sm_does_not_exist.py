"""Given: the "step functions" "state machine" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "state machine" did not exist')
def sm_does_not_exist(world):
    world["result"] = None
    world["error"] = None
