"""Given: ns_key in ns_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("ns_key in ns_status")
def ns_key_in_ns_status(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_and_namespace()
