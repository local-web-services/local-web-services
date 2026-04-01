"""Given: a namespace has been created in a table bucket"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("a namespace has been created in a table bucket")
def s3tables_a_namespace_has_been_created(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_and_namespace()
