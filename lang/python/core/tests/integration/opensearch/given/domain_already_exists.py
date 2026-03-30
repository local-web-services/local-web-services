"""Given: the domain already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OpensearchTestClient


@given("the domain already exists")
def domain_already_exists(client: TestClient):
    OpensearchTestClient(client).create_domain()
