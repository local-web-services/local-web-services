"""Given: a "s3" "bucket" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3apiTestClient


@given('a "s3" "bucket" is created')
def s3_bucket_has_been_created(lws_session):
    StepfunctionsS3apiTestClient(lws_session).create_bucket()
