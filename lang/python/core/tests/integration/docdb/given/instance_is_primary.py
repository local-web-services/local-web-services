"""Given: the "documentdb" "instance" is the primary"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DocdbTestClient


@given('the "documentdb" "instance" is the primary')
def instance_is_primary(client: TestClient):
    DocdbTestClient(client).create_cluster()
    DocdbTestClient(client).create_instance()
