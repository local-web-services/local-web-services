"""Given: object metadata has been retrieved from a bucket"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET, TEST_KEY


@given("object metadata has been retrieved from a bucket")
def object_metadata_has_been_retrieved(lws_session):
    S3apiTestClient(lws_session).put_object()
    S3apiTestClient(lws_session).head_object(Bucket=TEST_BUCKET, Key=TEST_KEY)
