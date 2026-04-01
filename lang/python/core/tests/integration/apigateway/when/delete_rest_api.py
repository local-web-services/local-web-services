"""When: a "api gateway" "REST API" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient


@when('a "api gateway" "REST API" is deleted')
def delete_rest_api(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found to delete"}
        return
    api_id = items[0]["id"]
    r = client.delete(f"/restapis/{api_id}")
    if r.status_code < 300:
        world["result"] = {}
    else:
        world["error"] = r.json()
