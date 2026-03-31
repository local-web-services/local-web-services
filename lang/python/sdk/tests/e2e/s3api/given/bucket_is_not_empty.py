"""Given: the "s3" "bucket" was not empty"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given('the "s3" "bucket" was not empty')
def bucket_is_not_empty(lws_session):
    S3apiTestClient(lws_session).put_object()
