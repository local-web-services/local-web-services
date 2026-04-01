"""When: a "lambda" "function" is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@when('a "lambda" "function" is created')
def create_function(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = LambdaTestClient(client).create_function()
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
