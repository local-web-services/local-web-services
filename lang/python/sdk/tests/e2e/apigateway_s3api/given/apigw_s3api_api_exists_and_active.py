"""Given: the "API" exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given('the "API" exists and is "ACTIVE"')
def apigw_s3api_api_exists_and_active(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_api()
