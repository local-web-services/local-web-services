"""Given: the bucket exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3tablesTestClient


@given("the bucket exists")
def bucket_exists(client: TestClient):
    S3tablesTestClient(client).create_bucket()
