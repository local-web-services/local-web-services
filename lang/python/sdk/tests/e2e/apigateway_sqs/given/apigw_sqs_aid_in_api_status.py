"""Given: aid in api_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySqsTestClient


@given("aid in api_status")
def apigw_sqs_aid_in_api_status(lws_session):
    ApigatewaySqsTestClient(lws_session).create_api()
