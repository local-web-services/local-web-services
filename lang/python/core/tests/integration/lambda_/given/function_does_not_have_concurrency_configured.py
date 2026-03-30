"""Given: the function does not have concurrency configured"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given("the function does not have concurrency configured")
def function_does_not_have_concurrency_configured(client: TestClient, world):
    LambdaTestClient(client).create_function()
    world["_skip"] = (
        "lws does not enforce concurrency configuration checks in stateless integration tests."
    )
