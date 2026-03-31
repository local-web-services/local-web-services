"""Given: the "s3" "bucket" did not exist or was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import ApigatewayS3apiTestClient
from ..constants import TEST_BUCKET


@given('the "s3" "bucket" did not exist or was "ACTIVE"')
def apigw_s3api_bucket_not_exist_or_not_active(lws_session, world):
    try:
        lws_session.client("s3").delete_bucket(Bucket=TEST_BUCKET)
    except Exception:
        pass
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    ApigatewayS3apiTestClient(lws_session).create_bucket()
    world["result"] = None
    world["error"] = None
