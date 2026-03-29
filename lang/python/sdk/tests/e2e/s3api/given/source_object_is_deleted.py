"""Given: the source object is deleted"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_KEY, TEST_SRC_BUCKET


@given("the source object is deleted")
def source_object_is_deleted(lws_session):
    S3apiTestClient(lws_session).put_object(bucket=TEST_SRC_BUCKET, key=TEST_KEY)
    S3apiTestClient(lws_session).delete_object(Bucket=TEST_SRC_BUCKET, Key=TEST_KEY)
