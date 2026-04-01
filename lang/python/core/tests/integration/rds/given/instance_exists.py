"""Given: the "documentdb" "instance" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import RdsTestClient


@given('the "documentdb" "instance" existed')
def instance_exists(client: TestClient):
    RdsTestClient(client).create_instance()
