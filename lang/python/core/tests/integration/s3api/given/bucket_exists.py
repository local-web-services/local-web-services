"""Given: the "s3" "bucket" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient


@given('the "s3" "bucket" existed')
def bucket_exists(sync_client: TestClient):
    S3apiTestClient(sync_client).create_bucket()
