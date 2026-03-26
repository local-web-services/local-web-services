"""Given: the parameter already exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import SsmTestClient


@given("the parameter already exists")
def parameter_already_exists(client: TestClient):
    SsmTestClient(client).put_parameter()
