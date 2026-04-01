"""When: a disabled lambda event source mapping was "ENABLED" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..client import LambdaTestClient


@when('a disabled lambda event source mapping was "ENABLED"')
def enable_disabled_esm(client: TestClient, world):
    uuid = LambdaTestClient(client).get_esm_uuid()
    r = client.put(f"/2015-03-31/event-source-mappings/{uuid}", json={"Enabled": True})
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
