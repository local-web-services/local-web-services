"""Given: a "REST" "API" has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given('a "REST" "API" has been created')
def apigw_sqs_rest_api_has_been_created(lws_session):
    ApigatewaySqsTestClient(lws_session).create_api()
