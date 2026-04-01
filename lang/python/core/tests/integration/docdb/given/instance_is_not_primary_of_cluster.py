"""Given: the "documentdb" "instance" is not the primary of the "documentdb" "cluster" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DocdbTestClient


@given('the "documentdb" "instance" is not the primary of the "documentdb" "cluster"')
def instance_is_not_primary_of_cluster(client: TestClient):
    DocdbTestClient(client).create_cluster()
    DocdbTestClient(client).create_instance()
