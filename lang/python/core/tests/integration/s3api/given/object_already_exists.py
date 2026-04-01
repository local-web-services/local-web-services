"""Given: the object already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import S3apiTestClient


@given("the object already exists")
def object_already_exists(sync_client: TestClient):
    S3apiTestClient(sync_client).put_object()
