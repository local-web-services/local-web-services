"""Given: the "s3" "object" was "deleted" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient
from ..constants import INT_BUCKET, INT_KEY


@given('the "s3" "object" was "deleted"')
def object_is_deleted(sync_client: TestClient):
    S3apiTestClient(sync_client).put_object()
    sync_client.delete(f"/{INT_BUCKET}/{INT_KEY}")
