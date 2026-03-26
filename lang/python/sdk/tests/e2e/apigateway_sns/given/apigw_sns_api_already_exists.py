"""Given: the "API" already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given('the "API" already exists')
def apigw_sns_api_already_exists(lws_session):
    ApigatewaySnsTestClient(lws_session).create_api()
