"""Given: the "s3" "object" was "deleted" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@given('the "s3" "object" was "deleted"')
def object_is_deleted(lws_session):
    S3apiTestClient(lws_session).put_object()
    S3apiTestClient(lws_session).delete_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
