"""Given: the object exists in the bucket"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given("the object exists in the bucket")
def object_exists_in_bucket(lws_session):
    S3apiTestClient(lws_session).put_object()
