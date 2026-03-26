"""Given: the bucket has active namespaces"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("the bucket has active namespaces")
def bucket_has_active_namespaces(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_and_namespace()
