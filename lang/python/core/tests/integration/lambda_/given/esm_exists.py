"""Given: the event source mapping exists"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given("the event source mapping exists")
def esm_exists(client: TestClient):
    LambdaTestClient(client).create_function()
    LambdaTestClient(client).create_esm()
