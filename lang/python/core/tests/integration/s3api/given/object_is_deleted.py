"""Given: the object is deleted"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient
from ..constants import INT_BUCKET, INT_KEY


@given("the object is deleted")
def object_is_deleted(sync_client: TestClient):
    S3apiTestClient(sync_client).put_object()
    sync_client.delete(f"/{INT_BUCKET}/{INT_KEY}")
