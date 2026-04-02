"""Given: a "s3 tables" "table" is created"""

from __future__ import annotations

from pytest_bdd import given

from ..client import StepfunctionsS3tablesTestClient


@given('a "s3 tables" "table" is created')
def s3tables_table_has_been_created(lws_session):
    StepfunctionsS3tablesTestClient(lws_session).create_table_bucket()
