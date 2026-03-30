"""Given: versions of a state machine have been listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM


@given("versions of a state machine have been listed")
def sm_versions_have_been_listed_given(lws_session, world):
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm()
