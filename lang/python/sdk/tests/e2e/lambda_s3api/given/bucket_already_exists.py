"""Given: the bucket already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3apiTestClient


@given("the bucket already exists")
def bucket_already_exists(lws_session):
    LambdaS3apiTestClient(lws_session).create_bucket()
