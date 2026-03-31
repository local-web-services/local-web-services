"""Given: the bucket already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiSnsTestClient


@given("the bucket already existed")
def bucket_already_exists(lws_session):
    S3apiSnsTestClient(lws_session).create_bucket()
