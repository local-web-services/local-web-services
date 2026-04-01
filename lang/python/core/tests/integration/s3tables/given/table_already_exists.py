"""Given: the "dynamodb" "table" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3tablesTestClient


@given('the "s3 tables" "table" already existed')
@given('the "dynamodb" "table" already existed')
def table_already_exists(client: TestClient):
    S3tablesTestClient(client).create_table()
