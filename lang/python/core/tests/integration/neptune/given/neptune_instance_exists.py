"""Given: the "documentdb" "instance" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import NeptuneTestClient


@given('the "neptune" "instance" existed')
@given('the "documentdb" "instance" existed')
def neptune_instance_exists(client: TestClient):
    NeptuneTestClient(client).create_cluster()
    NeptuneTestClient(client).create_instance()
