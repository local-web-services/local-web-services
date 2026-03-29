"""Given: the instance exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import NeptuneTestClient


@given("the instance exists")
def neptune_instance_exists(client: TestClient):
    NeptuneTestClient(client).create_cluster()
    NeptuneTestClient(client).create_instance()
