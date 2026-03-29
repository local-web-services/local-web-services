"""Given: the state machine is not an "EXPRESS" type"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM


@given('the state machine is not an "EXPRESS" type')
def sm_is_not_express_given(lws_session, world):
    """Ensure a STANDARD type state machine exists; no-op if already created."""
    if world.get("state_machine_arn") is None:
        world["state_machine_name"] = TEST_SM
        world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm(
            TEST_SM, sm_type="STANDARD"
        )
