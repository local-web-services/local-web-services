"""Given: bname in bucket_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("bname in bucket_status")
def bname_in_bucket_status(lws_session):
    S3tablesTestClient(lws_session).create_bucket()
