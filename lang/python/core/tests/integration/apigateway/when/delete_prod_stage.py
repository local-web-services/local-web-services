"""When: the "api gateway" "prod stage" is deleted"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_STAGE_PROD


@when('the "api gateway" "prod stage" is deleted')
def delete_prod_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    r = client.delete(f"/restapis/{api_id}/stages/{INT_STAGE_PROD}")
    if r.status_code < 300:
        world["result"] = {}
    else:
        world["error"] = r.json()
