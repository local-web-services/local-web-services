"""Given: src_bname in bucket_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_SRC_BUCKET


@given("src_bname in bucket_status")
def src_bname_in_bucket_status(lws_session):
    S3apiTestClient(lws_session).create_bucket(name=TEST_SRC_BUCKET)
