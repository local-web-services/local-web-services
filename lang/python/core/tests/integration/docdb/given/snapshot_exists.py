"""Given: the snapshot exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DocdbTestClient


@given("the snapshot exists")
def snapshot_exists(client: TestClient):
    DocdbTestClient(client).create_cluster()
    DocdbTestClient(client).create_snapshot()
