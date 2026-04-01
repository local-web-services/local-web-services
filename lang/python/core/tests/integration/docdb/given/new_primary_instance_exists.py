"""Given: the new primary "documentdb" "instance" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DocdbTestClient


@given('the new primary "documentdb" "instance" existed')
def new_primary_instance_exists(client: TestClient):
    DocdbTestClient(client).create_cluster()
    DocdbTestClient(client).create_instance()
