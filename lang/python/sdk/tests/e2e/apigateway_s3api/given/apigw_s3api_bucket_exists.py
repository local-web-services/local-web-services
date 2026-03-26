"""Given: the bucket exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given("the bucket exists")
def apigw_s3api_bucket_exists(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_bucket()
