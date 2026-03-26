"""Given: the bucket already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient


@given("the bucket already exists")
def bucket_already_exists(sync_client: TestClient):
    S3apiTestClient(sync_client).create_bucket()
