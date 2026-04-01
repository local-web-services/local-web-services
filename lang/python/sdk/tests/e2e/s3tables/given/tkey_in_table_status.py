"""Given: tkey in table_status"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given("tkey in table_status")
def tkey_in_table_status(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_namespace_table()
