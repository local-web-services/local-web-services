"""Given: a "REST" "API" has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayStepfunctionsTestClient


@given('a "REST" "API" has been created')
def apigw_sfn_rest_api_has_been_created(lws_session):
    ApigatewayStepfunctionsTestClient(lws_session).create_api()
