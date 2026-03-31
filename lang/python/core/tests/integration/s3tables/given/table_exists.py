"""Given: the "dynamodb" "table" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3tablesTestClient


@given('the "s3 tables" "table" existed')
@given('the "dynamodb" "table" existed')
def table_exists(client: TestClient):
    S3tablesTestClient(client).create_bucket()
    S3tablesTestClient(client).create_namespace()
    S3tablesTestClient(client).create_table()
