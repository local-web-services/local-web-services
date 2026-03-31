"""Given: the "documentdb" "cluster" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import NeptuneTestClient


@given('the "neptune" "cluster" existed')
@given('the "documentdb" "cluster" existed')
def cluster_exists(client: TestClient):
    NeptuneTestClient(client).create_cluster()
