"""Given: the "API" has an "SNS" integration configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given('the "API" has an "SNS" integration configured')
def apigw_sns_api_has_integration(lws_session, world):
    api_id = ApigatewaySnsTestClient(lws_session).get_api_id()
    if api_id is None:
        api_id = ApigatewaySnsTestClient(lws_session).create_api()
    ApigatewaySnsTestClient(lws_session).create_topic()
    ApigatewaySnsTestClient(lws_session).configure_sns_integration(api_id)
    world["api_id"] = api_id
