"""Given: the source bucket is not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_SRC_BUCKET


@given('the source bucket is not "ACTIVE"')
def source_bucket_is_not_active_given(lws_session):
    S3apiTestClient(lws_session).empty_and_delete_bucket(name=TEST_SRC_BUCKET)
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    S3apiTestClient(lws_session).create_bucket(name=TEST_SRC_BUCKET)
