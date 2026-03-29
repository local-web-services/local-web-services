"""Given: a state machine has been described"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsTestClient
from ..constants import TEST_SM


@given("a state machine has been described")
def sm_has_been_described_given(lws_session, world):
    world["state_machine_name"] = TEST_SM
    world["state_machine_arn"] = StepfunctionsTestClient(lws_session).create_sm()
