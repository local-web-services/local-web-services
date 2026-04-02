"""When: a 200 "api gateway" "method" response is configured"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_HTTP_METHOD, INT_STATUS_CODE


@when('a 200 "api gateway" "method" response is configured')
def put_method_response(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    resources_r = client.get(f"/restapis/{api_id}/resources")
    resource_items = resources_r.json().get("item", [])
    non_root = next((res for res in resource_items if res.get("path") != "/"), None)
    if non_root is None:
        world["error"] = {"message": "No non-root resource found"}
        return
    r = client.put(
        f"/restapis/{api_id}/resources/{non_root['id']}/methods/{INT_HTTP_METHOD}"
        f"/responses/{INT_STATUS_CODE}",
        json={"statusCode": INT_STATUS_CODE},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
