"""Given: the table already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("the table already exists")
def table_already_exists(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_namespace_table()
