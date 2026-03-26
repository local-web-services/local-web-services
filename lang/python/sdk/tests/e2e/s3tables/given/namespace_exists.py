"""Given: the namespace exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("the namespace exists")
def namespace_exists(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_and_namespace()
