"""Given: the execution exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM


@given("the execution exists")
def execution_exists(lws_session, world):
    if not world.get("state_machine_arn"):
        world["state_machine_name"] = TEST_SM
        world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm()
    sm_name = world.get("state_machine_name", TEST_SM)
    world["execution_arn"] = StepfunctionsTestClient(lws_session).start_execution(sm_name)
