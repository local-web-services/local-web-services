"""Given: the "API" has an "SQS" integration configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given('the "API" has an "SQS" integration configured')
def apigw_sqs_api_has_sqs_integration(lws_session, world):
    api_id = ApigatewaySqsTestClient(lws_session).get_api_id()
    if api_id is None:
        api_id = ApigatewaySqsTestClient(lws_session).create_api()
    ApigatewaySqsTestClient(lws_session).create_queue()
    ApigatewaySqsTestClient(lws_session).configure_sqs_integration(api_id)
    world["api_id"] = api_id
