"""Given: the "s3 tables" "table" already existed"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given('the "s3 tables" "table" already existed')
def table_already_exists(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_namespace_table()
