"""Given: a "s3" "object" is retrieved from a "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@given('a "s3" "object" is retrieved from a "s3" "bucket"')
def an_object_has_been_retrieved_from_a_bucket(lws_session):
    S3apiTestClient(lws_session).put_object()
    S3apiTestClient(lws_session).get_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
