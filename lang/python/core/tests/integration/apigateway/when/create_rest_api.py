"""When: a "REST" "API" is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_API_NAME


@when('a "REST" "API" is created')
@when('a "REST" "API" is created with a root resource')
def create_rest_api(client: TestClient, world):
    r = client.post("/restapis", json={"name": INT_API_NAME})
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
