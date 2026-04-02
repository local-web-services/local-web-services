"""Given: an "s3" "object" existed in the target "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3apiTestClient
from ..constants import TEST_BODY, TEST_BUCKET, TEST_KEY


@given('an "s3" "object" existed in the target "s3" "bucket"')
def object_exists_in_target_bucket(lws_session, world):
    StepfunctionsS3apiTestClient(lws_session).create_bucket()
    StepfunctionsS3apiTestClient(lws_session)._s3.put_object(
        Bucket=TEST_BUCKET, Key=TEST_KEY, Body=TEST_BODY
    )
    world["_object_in_target_bucket"] = True
