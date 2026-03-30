"""Given: the bucket already exists"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given("the bucket already exists")
def lambda_s3tables_bucket_already_exists(lws_session):
    try:
        LambdaS3tablesTestClient(lws_session).create_table_bucket()
    except Exception:
        pass
