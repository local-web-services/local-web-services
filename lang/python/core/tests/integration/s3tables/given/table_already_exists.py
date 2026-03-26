"""Given: the table already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3tablesTestClient


@given("the table already exists")
def table_already_exists(client: TestClient):
    S3tablesTestClient(client).create_table()
