"""When: a "lambda" event source mapping is created"""

from __future__ import annotations

import pytest
from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@when('a "lambda" event source mapping is created')
def create_event_source_mapping(client: TestClient, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    r = LambdaTestClient(client).create_esm()
    if r.status_code < 300:
        world["result"] = r.json()
        world["esm_uuid"] = r.json().get("UUID", "")
    else:
        world["error"] = r.json()
