"""Given: an object has been uploaded to a bucket"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiTestClient


@given("an object has been uploaded to a bucket")
def an_object_has_been_uploaded_to_a_bucket(lws_session):
    S3apiTestClient(lws_session).put_object()
