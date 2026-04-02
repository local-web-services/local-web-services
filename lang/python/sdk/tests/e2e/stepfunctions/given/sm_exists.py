"""Given: all "step functions" "state machine"s are listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM


@given('the "step functions" "state machine" existed')
def sm_exists(lws_session, world):
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm()
