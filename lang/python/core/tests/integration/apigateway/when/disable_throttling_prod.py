"""When: throttling was "DISABLED" for the "api gateway" "prod stage" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_STAGE_PROD


@when('throttling was "DISABLED" for the "api gateway" "prod stage"')
def disable_throttling_prod(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.patch(
        f"/restapis/{api_id}/stages/{INT_STAGE_PROD}",
        json={"patchOperations": []},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
