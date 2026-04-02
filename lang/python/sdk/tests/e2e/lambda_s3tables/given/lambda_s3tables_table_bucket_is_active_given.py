"""Given: the "s3 tables" "bucket" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given('the "s3 tables" "bucket" was "ACTIVE"')
def lambda_s3tables_table_bucket_is_active_given(lws_session):
    try:
        LambdaS3tablesTestClient(lws_session).create_table_bucket()
    except Exception:
        pass
