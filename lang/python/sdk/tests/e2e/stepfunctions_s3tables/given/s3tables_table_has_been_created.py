"""Given: an S3 Tables table has been created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given("an S3 Tables table has been created")
def s3tables_table_has_been_created(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
