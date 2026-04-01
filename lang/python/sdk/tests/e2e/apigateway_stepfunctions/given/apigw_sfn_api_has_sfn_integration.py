"""Given: the "api gateway" "api" has a Step Functions integration configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given('the "api gateway" "api" has a Step Functions integration configured')
def apigw_sfn_api_has_sfn_integration(lws_session, world):
    api_id = ApigatewayStepfunctionsTestClient(lws_session).get_api_id()
    if api_id is None:
        api_id = ApigatewayStepfunctionsTestClient(lws_session).create_api()
    ApigatewayStepfunctionsTestClient(lws_session).create_sm()
    ApigatewayStepfunctionsTestClient(lws_session).configure_sfn_integration(api_id)
    world["api_id"] = api_id
