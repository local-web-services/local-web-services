"""Given: a bucket has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given("a bucket has been created")
def a_bucket_has_been_created(lws_session):
    S3apiTestClient(lws_session).create_bucket()
