"""Given: the database instance exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import RdsTestClient


@given("the database instance exists")
def db_instance_exists(client: TestClient):
    RdsTestClient(client).create_instance()
