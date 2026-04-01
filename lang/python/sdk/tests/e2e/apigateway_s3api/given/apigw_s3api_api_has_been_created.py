"""Given: an "api gateway" "api" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given('an "api gateway" "api" is created')
def apigw_s3api_api_has_been_created(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_api()
