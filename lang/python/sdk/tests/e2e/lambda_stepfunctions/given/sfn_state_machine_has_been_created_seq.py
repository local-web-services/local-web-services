"""Given: a "step functions" "state machine" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaStepfunctionsTestClient


@given('a "step functions" "state machine" is created')
def sfn_state_machine_has_been_created_seq(lws_session):
    LambdaStepfunctionsTestClient(lws_session).create_sm()
