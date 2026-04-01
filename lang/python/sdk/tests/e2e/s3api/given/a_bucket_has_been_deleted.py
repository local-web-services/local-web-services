"""Given: a "s3" "bucket" is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given('a "s3" "bucket" is deleted')
def a_bucket_has_been_deleted(lws_session):
    S3apiTestClient(lws_session).create_bucket()
    S3apiTestClient(lws_session).empty_and_delete_bucket()
