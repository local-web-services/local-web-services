"""Given: the source object exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_KEY, TEST_SRC_BUCKET


@given("the source object exists")
def source_object_exists(lws_session):
    S3apiTestClient(lws_session).put_object(bucket=TEST_SRC_BUCKET, key=TEST_KEY)
