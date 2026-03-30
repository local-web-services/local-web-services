"""Given: an S3 bucket has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3apiTestClient


@given("an S3 bucket has been created")
def s3_bucket_has_been_created(lws_session):
    StepfunctionsS3apiTestClient(lws_session).create_bucket()
