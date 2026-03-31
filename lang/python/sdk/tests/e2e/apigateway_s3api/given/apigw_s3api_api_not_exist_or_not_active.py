"""Given: the "api gateway" "API" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given('the "api gateway" "API" did not exist or was "ACTIVE"')
def apigw_s3api_api_not_exist_or_not_active(lws_session, world):
    api_id = ApigatewayS3apiTestClient(lws_session).get_api_id()
    if api_id:
        try:
            lws_session.client("apigateway").delete_rest_api(restApiId=api_id)
        except Exception:
            pass
    lws_session.lifecycle("apigateway").create_dwell_ms(5000).apply()
    ApigatewayS3apiTestClient(lws_session).create_api()
    world["result"] = None
    world["error"] = None
