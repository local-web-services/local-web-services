"""Given: the "lambda" "function" already existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given('the "lambda" "function" already existed')
def function_already_exists(client: TestClient, world):
    LambdaTestClient(client).create_function()
    world["_skip"] = "lws does not enforce function uniqueness in stateless integration tests."
