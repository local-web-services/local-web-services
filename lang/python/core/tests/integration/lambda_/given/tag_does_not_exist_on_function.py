"""Given: the tag did not exist on the "lambda" "function" """

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given('the tag did not exist on the "lambda" "function"')
def tag_does_not_exist_on_function(client: TestClient, world):
    LambdaTestClient(client).create_function()
    world["_skip"] = "lws does not enforce tag existence checks in stateless integration tests."
