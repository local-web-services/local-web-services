"""Given: the execution exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import StepfunctionsTestClient
from ..constants import INT_SM


@given("the execution exists")
def execution_exists(client: TestClient, world):
    if not world.get("state_machine_arn"):
        world["state_machine_name"] = INT_SM
        world["state_machine_arn"] = StepfunctionsTestClient(client).create_sm()
    sm_name = world.get("state_machine_name", INT_SM)
    world["execution_arn"] = StepfunctionsTestClient(client).start_execution(sm_name)
