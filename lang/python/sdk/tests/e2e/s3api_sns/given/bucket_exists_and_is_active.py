"""Given: the "s3" "bucket" existed and was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given('the "s3" "bucket" existed and was "ACTIVE"')
def bucket_exists_and_is_active(lws_session):
    S3apiSnsTestClient(lws_session).create_bucket()
