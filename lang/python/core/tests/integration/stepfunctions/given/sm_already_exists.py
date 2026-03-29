"""Given: the state machine already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import StepfunctionsTestClient
from ..constants import INT_SM


@given("the state machine already exists")
def sm_already_exists(client: TestClient, world):
    world["state_machine_name"] = INT_SM
    world["state_machine_arn"] = StepfunctionsTestClient(client).create_sm()
