"""Given: the "s3 tables" "namespace" had active tables"""

from __future__ import annotations

from pytest_bdd import given

from ..client import S3tablesTestClient


@given('the "s3 tables" "namespace" had active tables')
def namespace_has_active_tables(lws_session):
    S3tablesTestClient(lws_session).setup_bucket_namespace_table()
