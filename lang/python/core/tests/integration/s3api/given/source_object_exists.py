"""Given: the source "s3" "object" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient
from ..constants import INT_KEY, INT_SRC_BUCKET


@given('the source "s3" "object" existed')
def source_object_exists(sync_client: TestClient):
    S3apiTestClient(sync_client).put_object(bucket=INT_SRC_BUCKET, key=INT_KEY)
