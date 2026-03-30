"""Given: the object is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@given('the object is not "ACTIVE"')
def object_is_not_active_given(lws_session):
    try:
        S3apiTestClient(lws_session).delete_bucket(Bucket=TEST_BUCKET)
    except Exception:
        pass
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    S3apiTestClient(lws_session).create_bucket()
