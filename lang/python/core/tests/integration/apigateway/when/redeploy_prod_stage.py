"""When: the "api gateway" "prod stage" is redeployed to a new deployment"""

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_STAGE_PROD


@when('the "api gateway" "prod stage" is redeployed to a new deployment')
def redeploy_prod_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    # Find the API that has the prod stage (may differ from items[0] when multiple APIs exist)
    api_id = None
    for item in items:
        stages_r = client.get(f"/restapis/{item['id']}/stages/{INT_STAGE_PROD}")
        if stages_r.status_code < 300:
            api_id = item["id"]
            break
    if api_id is None:
        world["error"] = {"message": f"No REST API found with a '{INT_STAGE_PROD}' stage"}
        return
    new_deployment_r = client.post(f"/restapis/{api_id}/deployments", json={})
    if new_deployment_r.status_code >= 300:
        world["error"] = new_deployment_r.json()
        return
    new_deployment_id = new_deployment_r.json()["id"]
    r = client.patch(
        f"/restapis/{api_id}/stages/{INT_STAGE_PROD}",
        json={
            "patchOperations": [
                {"op": "replace", "path": "/deploymentId", "value": new_deployment_id}
            ]
        },
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
