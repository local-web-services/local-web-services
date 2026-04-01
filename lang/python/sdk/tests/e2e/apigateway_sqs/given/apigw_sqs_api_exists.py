"""Given: the "api gateway" "API" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given('the "api gateway" "API" existed')
def apigw_sqs_api_exists(lws_session):
    ApigatewaySqsTestClient(lws_session).create_api()
