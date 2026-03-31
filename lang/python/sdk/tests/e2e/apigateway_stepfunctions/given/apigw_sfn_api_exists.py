"""Given: the "api gateway" "API" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given('the "api gateway" "API" existed')
def apigw_sfn_api_exists(lws_session):
    ApigatewayStepfunctionsTestClient(lws_session).create_api()
