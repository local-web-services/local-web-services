"""Given: the "api gateway" "api" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given('the "api gateway" "api" was not "ACTIVE"')
def apigw_sfn_api_is_not_active_given(lws_session, world):
    api_id = ApigatewayStepfunctionsTestClient(lws_session).get_api_id()
    if api_id:
        try:
            lws_session.client("apigateway").delete_rest_api(restApiId=api_id)
        except Exception:
            pass
    lws_session.lifecycle("apigateway").create_dwell_ms(5000).apply()
    ApigatewayStepfunctionsTestClient(lws_session).create_api()
    world["result"] = None
    world["error"] = None
