"""Given: the "API" has an S3 integration configured"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given('the "API" has an S3 integration configured')
def apigw_s3api_api_has_integration(lws_session, world):
    api_id = ApigatewayS3apiTestClient(lws_session).get_api_id()
    if api_id is None:
        api_id = ApigatewayS3apiTestClient(lws_session).create_api()
    ApigatewayS3apiTestClient(lws_session).create_bucket()
    ApigatewayS3apiTestClient(lws_session).configure_s3_integration(api_id)
    world["api_id"] = api_id
