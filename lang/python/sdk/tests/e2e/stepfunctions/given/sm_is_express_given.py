"""Given: the state machine is an "EXPRESS" type"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM_EXPRESS


@given('the state machine is an "EXPRESS" type')
def sm_is_express_given(lws_session, world):
    world["state_machine_name"] = TEST_SM_EXPRESS
    world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm(
        TEST_SM_EXPRESS, sm_type="EXPRESS"
    )
