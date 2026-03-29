"""Given: the state machine does not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the state machine does not already exist")
def apigw_sfn_sm_not_already_exist():
    """No-op: fresh state has no state machines."""
