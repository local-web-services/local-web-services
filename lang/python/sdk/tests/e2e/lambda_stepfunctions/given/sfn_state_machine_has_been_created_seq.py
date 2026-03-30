"""Given: a Step Functions state machine has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient


@given("a Step Functions state machine has been created")
def sfn_state_machine_has_been_created_seq(lws_session):
    LambdaStepfunctionsTestClient(lws_session).create_sm()
