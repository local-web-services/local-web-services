"""Given: the "step functions" "state machine" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "step functions" "state machine" did not exist')
def apigw_sfn_sm_does_not_exist(world):
    world["_skip"] = "Cannot validate state machine existence at put_integration time in lws."
