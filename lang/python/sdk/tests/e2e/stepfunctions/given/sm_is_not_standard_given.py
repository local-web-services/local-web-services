"""Given: the state machine is not a "STANDARD" type"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM_EXPRESS


@given('the state machine is not a "STANDARD" type')
def sm_is_not_standard_given(lws_session, world):
    """Create an EXPRESS type state machine instead."""
    world["state_machine_name"] = TEST_SM_EXPRESS
    world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm(
        TEST_SM_EXPRESS, sm_type="EXPRESS"
    )
