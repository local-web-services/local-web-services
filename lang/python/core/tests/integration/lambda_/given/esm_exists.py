"""Given: the "lambda" "event source mapping" existed"""

from __future__ import annotations

from pytest_bdd import given
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@given('the "lambda" "event source mapping" existed')
@given('the "lambda" "event source mapping" existed')
def esm_exists(client: TestClient):
    LambdaTestClient(client).create_function()
    LambdaTestClient(client).create_esm()
