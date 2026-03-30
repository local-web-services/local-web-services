"""Given: an object has been deleted from a bucket"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@given("an object has been deleted from a bucket")
def an_object_has_been_deleted_from_a_bucket(lws_session):
    S3apiTestClient(lws_session).put_object()
    S3apiTestClient(lws_session).delete_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
