"""When: an "api gateway" "API" deployment is created"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient


@when('an "api gateway" "API" deployment is created')
def create_deployment(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.post(f"/restapis/{api_id}/deployments", json={})
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
