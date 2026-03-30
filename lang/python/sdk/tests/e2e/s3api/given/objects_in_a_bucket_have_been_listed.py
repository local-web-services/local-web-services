"""Given: objects in a bucket have been listed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_BUCKET


@given("objects in a bucket have been listed")
def objects_in_a_bucket_have_been_listed(lws_session):
    S3apiTestClient(lws_session).create_bucket()
    S3apiTestClient(lws_session).list_objects_v2(Bucket=TEST_BUCKET)
