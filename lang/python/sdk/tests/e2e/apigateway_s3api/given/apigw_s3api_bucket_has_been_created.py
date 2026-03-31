"""Given: a "s3" "bucket" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given('a "s3" "bucket" is created')
def apigw_s3api_bucket_has_been_created(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_bucket()
