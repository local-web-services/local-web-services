"""Given: a table bucket has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("a table bucket has been created")
def s3tables_a_table_bucket_has_been_created(lws_session):
    try:
        S3tablesTestClient(lws_session).create_bucket()
    except Exception:
        pass
