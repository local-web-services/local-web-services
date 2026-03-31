"""Given: tags are removed from a "step functions" "state machine" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM


@given('tags are removed from a "step functions" "state machine"')
def tags_removed_from_sm_given(lws_session, world):
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm()
