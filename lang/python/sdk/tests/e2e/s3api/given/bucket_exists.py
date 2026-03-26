"""Given: the bucket exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given("the bucket exists")
def bucket_exists(lws_session):
    S3apiTestClient(lws_session).create_bucket()
