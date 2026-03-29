"""Given: an S3 table bucket has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import LambdaS3tablesTestClient


@given("an S3 table bucket has been created")
def lambda_s3tables_table_bucket_has_been_created_seq(lws_session):
    LambdaS3tablesTestClient(lws_session).create_table_bucket()
