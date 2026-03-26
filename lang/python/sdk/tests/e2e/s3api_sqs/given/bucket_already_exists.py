"""Given: the bucket already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSqsTestClient


@given("the bucket already exists")
def bucket_already_exists(lws_session):
    S3apiSqsTestClient(lws_session).create_bucket()
