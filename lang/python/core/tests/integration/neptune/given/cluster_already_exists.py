"""Given: the cluster already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import NeptuneTestClient


@given("the cluster already exists")
def cluster_already_exists(client: TestClient):
    NeptuneTestClient(client).create_cluster()
