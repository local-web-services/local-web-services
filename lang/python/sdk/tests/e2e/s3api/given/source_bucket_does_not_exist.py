"""Given: the source bucket does not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient
from ..constants import TEST_SRC_BUCKET


@given("the source bucket does not exist")
def source_bucket_does_not_exist(lws_session):
    """Ensure the source bucket does not exist by deleting it if present."""
    S3apiTestClient(lws_session).empty_and_delete_bucket(name=TEST_SRC_BUCKET)
