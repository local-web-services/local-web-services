"""Given: the "s3" "bucket" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3tablesTestClient


@given('the "s3 tables" "bucket" already existed')
@given('the "s3" "bucket" already existed')
def bucket_already_exists(client: TestClient):
    S3tablesTestClient(client).create_bucket()
