"""Given: the "documentdb" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given('the "memorydb" "cluster" already existed')
@given('the "documentdb" "cluster" already existed')
def cluster_already_exists(client: TestClient):
    MemorydbTestClient(client).create_cluster()
