"""Given: aid in api_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given("aid in api_status")
def apigw_sfn_aid_in_api_status(lws_session):
    ApigatewayStepfunctionsTestClient(lws_session).create_api()
