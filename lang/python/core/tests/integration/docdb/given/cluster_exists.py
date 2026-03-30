"""Given: the cluster exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DocdbTestClient


@given("the cluster exists")
def cluster_exists(client: TestClient):
    DocdbTestClient(client).create_cluster()
