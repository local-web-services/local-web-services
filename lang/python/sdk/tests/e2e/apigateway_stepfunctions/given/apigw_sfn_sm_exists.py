"""Given: the state machine exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given("the state machine exists")
def apigw_sfn_sm_exists(lws_session):
    ApigatewayStepfunctionsTestClient(lws_session).create_sm()
