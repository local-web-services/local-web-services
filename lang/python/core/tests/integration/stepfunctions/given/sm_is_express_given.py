"""Given: the "step functions" "state machine" is an "EXPRESS" type"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import StepfunctionsTestClient
from ..constants import INT_SM_EXPRESS


@given('the "step functions" "state machine" is an "EXPRESS" type')
def sm_is_express_given(client: TestClient, world):
    world["state_machine_name"] = INT_SM_EXPRESS
    world["state_machine_arn"] = StepfunctionsTestClient(client).create_sm(
        INT_SM_EXPRESS, sm_type="EXPRESS"
    )
