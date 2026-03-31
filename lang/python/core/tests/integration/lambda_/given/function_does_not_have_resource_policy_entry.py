"""Given: the "lambda" "function" did not have a resource policy entry"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given('the "lambda" "function" did not have a resource policy entry')
def function_does_not_have_resource_policy_entry(client: TestClient, world):
    LambdaTestClient(client).create_function()
    world["_skip"] = (
        "lws does not enforce resource policy entry existence checks"
        " in stateless integration tests."
    )
