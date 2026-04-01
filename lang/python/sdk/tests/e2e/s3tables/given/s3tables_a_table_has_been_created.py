"""Given: a table has been created in a namespace"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("a table has been created in a namespace")
def s3tables_a_table_has_been_created(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_namespace_table()
