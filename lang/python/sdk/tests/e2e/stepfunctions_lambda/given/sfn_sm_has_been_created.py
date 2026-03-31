"""Given: a "step functions" "state machine" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsLambdaTestClient


@given('a "step functions" "state machine" is created')
def sfn_sm_has_been_created(lws_session):
    StepfunctionsLambdaTestClient(lws_session).create_sm()
