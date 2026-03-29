"""Given: src_bname in bucket_status"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient
from ..constants import INT_SRC_BUCKET


@given("src_bname in bucket_status")
def src_bname_in_bucket_status(sync_client: TestClient):
    S3apiTestClient(sync_client).create_bucket(name=INT_SRC_BUCKET)
