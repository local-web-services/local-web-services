"""Given: the "s3" "bucket" was not empty"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient


@given('the "s3" "bucket" was not empty')
def bucket_is_not_empty(sync_client: TestClient):
    S3apiTestClient(sync_client).put_object()
