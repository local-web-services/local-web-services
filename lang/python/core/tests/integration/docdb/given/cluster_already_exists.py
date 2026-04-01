"""Given: the "documentdb" "cluster" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DocdbTestClient


@given('the "documentdb" "cluster" already existed')
def cluster_already_exists(client: TestClient):
    DocdbTestClient(client).create_cluster()
