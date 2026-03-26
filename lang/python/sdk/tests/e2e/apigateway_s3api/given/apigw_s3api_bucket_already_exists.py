"""Given: the bucket already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given("the bucket already exists")
def apigw_s3api_bucket_already_exists(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_bucket()
