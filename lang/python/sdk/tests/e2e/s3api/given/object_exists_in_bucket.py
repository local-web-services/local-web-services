"""Given: the "s3" "object" existed in the "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given('the "s3" "object" existed in the "s3" "bucket"')
def object_exists_in_bucket(lws_session):
    S3apiTestClient(lws_session).put_object()
