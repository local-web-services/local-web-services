"""Given: an S3 bucket has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3apiTestClient


@given("an S3 bucket has been created")
def s3_bucket_has_been_created_seq(lws_session):
    LambdaS3apiTestClient(lws_session).create_bucket()
