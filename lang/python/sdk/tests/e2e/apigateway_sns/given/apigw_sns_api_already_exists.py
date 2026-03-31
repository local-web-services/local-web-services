"""Given: the "sns" "topic" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given('the "api gateway" "API" already existed')
def apigw_sns_api_already_exists(lws_session):
    ApigatewaySnsTestClient(lws_session).create_api()
