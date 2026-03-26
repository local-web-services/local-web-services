"""Given: the state machine is "DELETING" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM, _sm_arn


@given('the state machine is "DELETING"')
def sm_is_deleting_given(lws_session, world):
    """Delete the SM so it enters DELETING state."""
    sm_name = world.get("state_machine_name", TEST_SM)
    StepfunctionsTestClient(lws_session).delete_state_machine(stateMachineArn=_sm_arn(sm_name))
