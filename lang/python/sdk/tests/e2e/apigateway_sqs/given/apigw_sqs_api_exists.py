"""Given: the "API" exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given('the "API" exists')
def apigw_sqs_api_exists(lws_session):
    ApigatewaySqsTestClient(lws_session).create_api()
