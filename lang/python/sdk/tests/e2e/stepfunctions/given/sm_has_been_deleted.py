"""Given: all state machines are listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM, _sm_arn


@given("all state machines are listed")
def sm_has_been_deleted(lws_session, world):
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm()
    StepfunctionsTestClient(lws_session).delete_state_machine(stateMachineArn=_sm_arn())
