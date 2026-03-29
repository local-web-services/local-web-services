"""Given: the table exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3tablesTestClient


@given("the table exists")
def table_exists(client: TestClient):
    S3tablesTestClient(client).create_bucket()
    S3tablesTestClient(client).create_namespace()
    S3tablesTestClient(client).create_table()
