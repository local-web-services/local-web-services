"""Given: a trail is created with an S3 bucket"""

from __future__ import annotations

from pytest_bdd import given

from ..client import CloudtrailTestClient


@given("a trail is created with an S3 bucket")
def a_trail_is_created_with_an_s3_bucket(lws_session):
    CloudtrailTestClient(lws_session).create_trail()
