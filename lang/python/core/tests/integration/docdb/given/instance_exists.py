"""Given: the instance exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import DocdbTestClient


@given("the instance exists")
def instance_exists(client: TestClient):
    DocdbTestClient(client).create_cluster()
    DocdbTestClient(client).create_instance()
