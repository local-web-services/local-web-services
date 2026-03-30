"""Given: the cluster exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import MemorydbTestClient


@given("the cluster exists")
def cluster_exists(client: TestClient):
    MemorydbTestClient(client).create_cluster()
