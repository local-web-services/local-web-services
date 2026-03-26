"""When: a dev stage is created for an "API" """

from __future__ import annotations

from pytest_bdd import when
from starlette.testclient import TestClient

from ..constants import INT_STAGE_DEV


@when('a dev stage is created for an "API"')
def create_dev_stage(client: TestClient, world):
    list_r = client.get("/restapis")
    items = list_r.json().get("item", [])
    if not items:
        world["error"] = {"message": "No REST API found"}
        return
    api_id = items[0]["id"]
    deployments_r = client.get(f"/restapis/{api_id}/deployments")
    deployment_items = deployments_r.json().get("item", [])
    if not deployment_items:
        world["error"] = {"message": "No deployment found to create stage from"}
        return
    deployment_id = deployment_items[0]["id"]
    r = client.post(
        f"/restapis/{api_id}/stages",
        json={"stageName": INT_STAGE_DEV, "deploymentId": deployment_id},
    )
    if r.status_code < 300:
        world["result"] = r.json()
    else:
        world["error"] = r.json()
