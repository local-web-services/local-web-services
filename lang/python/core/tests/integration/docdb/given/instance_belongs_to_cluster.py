"""Given: the "documentdb" "instance" belongs to this documentdb cluster"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DocdbTestClient


@given('the "documentdb" "instance" belongs to this documentdb cluster')
def instance_belongs_to_cluster(client: TestClient):
    DocdbTestClient(client).create_cluster()
    DocdbTestClient(client).create_instance()
