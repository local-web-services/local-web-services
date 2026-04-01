"""Given: the "api gateway" "API" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given('the "api gateway" "API" already existed')
def apigw_s3api_api_already_exists(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_api()
