"""Given: the bucket does not already exist"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given("the bucket does not already exist")
def bucket_not_already_exist(lws_session):
    """Ensure the bucket does not exist by deleting it if present."""
    S3apiTestClient(lws_session).empty_and_delete_bucket()
