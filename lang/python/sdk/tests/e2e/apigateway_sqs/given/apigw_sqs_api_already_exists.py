"""Given: the "API" already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given('the "API" already exists')
def apigw_sqs_api_already_exists(lws_session):
    ApigatewaySqsTestClient(lws_session).create_api()
