"""When: a child "api gateway" "resource" is created under an existing "api gateway" "resource" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_RESOURCE_PATH


@when('a child "api gateway" "resource" is created under an existing "api gateway" "resource"')
def create_child_resource(client: TestClient, world):
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
    r = client.post(
        f"/restapis/{api_id}/resources/{root_id}",
        json={"pathPart": INT_RESOURCE_PATH},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
