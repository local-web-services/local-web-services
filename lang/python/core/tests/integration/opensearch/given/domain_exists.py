"""Given: the domain exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import OpensearchTestClient


@given("the domain exists")
def domain_exists(client: TestClient):
    OpensearchTestClient(client).create_domain()
