"""Given: the cluster exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import NeptuneTestClient


@given("the cluster exists")
def cluster_exists(client: TestClient):
    NeptuneTestClient(client).create_cluster()
