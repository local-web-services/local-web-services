"""Given: the "documentdb" "snapshot" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given('the "memorydb" "snapshot" existed')
@given('the "documentdb" "snapshot" existed')
def snapshot_exists(client: TestClient):
    MemorydbTestClient(client).create_cluster()
    MemorydbTestClient(client).create_snapshot()
