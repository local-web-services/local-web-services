"""Given: the bucket exists and is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import S3apiEventsTestClient


@given('the bucket exists and is "ACTIVE"')
def bucket_exists_and_is_active(lws_session):
    S3apiEventsTestClient(lws_session).create_bucket()
