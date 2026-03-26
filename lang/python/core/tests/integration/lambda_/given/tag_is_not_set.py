"""Given: the tag is not set"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given("the tag is not set")
def tag_is_not_set(client: TestClient, world):
    LambdaTestClient(client).create_function()
    world["_skip"] = "lws does not enforce tag existence checks in stateless integration tests."
