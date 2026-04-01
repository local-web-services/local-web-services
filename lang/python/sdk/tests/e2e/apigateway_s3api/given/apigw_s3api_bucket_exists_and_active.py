"""Given: the "s3" "bucket" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given('the "s3" "bucket" existed and was "ACTIVE"')
def apigw_s3api_bucket_exists_and_active(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_bucket()
