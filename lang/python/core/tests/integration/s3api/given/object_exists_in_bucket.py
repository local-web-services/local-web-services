"""Given: the "s3" "object" existed in the "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient


@given('the "s3" "object" existed in the "s3" "bucket"')
def object_exists_in_bucket(sync_client: TestClient):
    S3apiTestClient(sync_client).put_object()
