"""Given: the S3 bucket has been deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient


@given("the S3 bucket has been deleted")
def apigw_s3api_bucket_has_been_deleted(lws_session):
    ApigatewayS3apiTestClient(lws_session).create_bucket()
    ApigatewayS3apiTestClient(lws_session)._s3.delete_bucket(Bucket="e2e-test-bucket-1")
