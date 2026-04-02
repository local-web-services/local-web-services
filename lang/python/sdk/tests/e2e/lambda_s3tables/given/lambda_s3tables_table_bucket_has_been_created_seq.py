"""Given: a "s3 tables" "bucket" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given('a "s3 tables" "bucket" is created')
def lambda_s3tables_table_bucket_has_been_created_seq(lws_session):
    LambdaS3tablesTestClient(lws_session).create_table_bucket()
