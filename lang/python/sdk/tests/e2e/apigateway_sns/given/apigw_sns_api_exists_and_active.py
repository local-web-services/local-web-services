"""Given: the "API" exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given('the "API" exists and is "ACTIVE"')
def apigw_sns_api_exists_and_active(lws_session):
    ApigatewaySnsTestClient(lws_session).create_api()
