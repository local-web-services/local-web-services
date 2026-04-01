"""Given: the source "s3" "bucket" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient
from ..constants import INT_BUCKET, INT_SRC_BUCKET


@given('the source "s3" "bucket" existed')
def source_bucket_exists(sync_client: TestClient):
    S3apiTestClient(sync_client).create_bucket(name=INT_SRC_BUCKET)
    S3apiTestClient(sync_client).create_bucket(name=INT_BUCKET)
