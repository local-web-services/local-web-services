"""Given: the event source mapping already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given('the "lambda" "event source mapping" already existed')
@given("the event source mapping already existed")
def esm_already_exists(client: TestClient, world):
    LambdaTestClient(client).create_function()
    LambdaTestClient(client).create_esm()
    world["_skip"] = (
        "lws does not enforce event source mapping uniqueness in stateless integration tests."
    )
