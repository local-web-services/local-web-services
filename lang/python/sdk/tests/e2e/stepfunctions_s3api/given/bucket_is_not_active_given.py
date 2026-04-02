"""Given: the "s3" "bucket" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3apiTestClient
from ..constants import TEST_BUCKET


@given('the "s3" "bucket" was not "ACTIVE"')
def bucket_is_not_active_given(lws_session, world):
    try:
        StepfunctionsS3apiTestClient(lws_session)._s3.delete_bucket(Bucket=TEST_BUCKET)
    except Exception:
        pass
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    StepfunctionsS3apiTestClient(lws_session).create_bucket()
    world["result"] = None
    world["error"] = None
    world["_skip"] = "lws does not validate bucket lifecycle state during update_state_machine"
