"""Given: the state machine exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsLambdaTestClient


@given("the state machine exists")
def sm_exists(lws_session):
    StepfunctionsLambdaTestClient(lws_session).create_sm()
