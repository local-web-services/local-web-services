"""Given: the state machine already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given("the state machine already exists")
def apigw_sfn_sm_already_exists(lws_session):
    ApigatewayStepfunctionsTestClient(lws_session).create_sm()
