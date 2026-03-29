"""When: a root resource is initialized for an "API" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient


@when('a root resource is initialized for an "API"')
def init_root_resource(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    root_id = next((res["id"] for res in resource_items if res.get("path") == "/"), None)
    if root_id is None:
        world["error"] = {"message": "No root resource found"}
        return
    world["result"] = {"id": root_id, "path": "/"}
