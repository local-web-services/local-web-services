"""Given: the "step functions" "state machine" is not an "EXPRESS" type"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import StepfunctionsTestClient
from ..constants import INT_SM


@given('the "step functions" "state machine" is not an "EXPRESS" type')
def sm_is_not_express_given(client: TestClient, world):
    if world.get("state_machine_arn") is None:
        world["state_machine_name"] = INT_SM
        world["state_machine_arn"] = StepfunctionsTestClient(client).create_sm(
            INT_SM, sm_type="STANDARD"
        )
