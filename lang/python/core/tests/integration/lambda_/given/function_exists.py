"""Given: the "lambda" "function" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given('the "lambda" "function" existed')
def function_exists(client: TestClient):
    LambdaTestClient(client).create_function()
