"""Given: an "API" Gateway "REST" "API" has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewaySnsTestClient


@given('an "API" Gateway "REST" "API" has been created')
def apigw_sns_api_has_been_created(lws_session):
    ApigatewaySnsTestClient(lws_session).create_api()
