"""Given: the "documentdb" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given('the "memorydb" "cluster" existed')
@given('the "documentdb" "cluster" existed')
def cluster_exists(client: TestClient):
    MemorydbTestClient(client).create_cluster()
