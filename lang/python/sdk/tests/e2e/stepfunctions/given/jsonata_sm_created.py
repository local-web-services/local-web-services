"""Given: a JSONata "step functions" "state machine" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import JSONATA_SM


@given('a JSONata "step functions" "state machine" is created')
def jsonata_sm_created(lws_session, world):
    world["state_machine_name"] = JSONATA_SM
    StepfunctionsTestClient(lws_session).create_jsonata_sm()
