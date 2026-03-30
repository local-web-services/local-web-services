"""Given: the bucket is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3apiTestClient
from ..constants import TEST_BUCKET


@given('the bucket is not "ACTIVE"')
def bucket_is_not_active_given(lws_session, world):
    try:
        LambdaS3apiTestClient(lws_session)._s3.delete_bucket(Bucket=TEST_BUCKET)
    except Exception:
        pass
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    LambdaS3apiTestClient(lws_session).create_bucket()
    world["result"] = None
    world["error"] = None
