"""Given: the "s3" "bucket" was not "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given('the "s3" "bucket" was not "ACTIVE"')
def bucket_is_not_active_given(lws_session):
    S3apiTestClient(lws_session).empty_and_delete_bucket()
    lws_session.lifecycle("s3").create_dwell_ms(5000).apply()
    S3apiTestClient(lws_session).create_bucket()
