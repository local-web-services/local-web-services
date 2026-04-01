"""Given: the "s3 tables" "bucket" existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given('the "s3 tables" "bucket" existed')
def bucket_exists(lws_session):
    S3tablesTestClient(lws_session).create_bucket()
