"""When: a dev stage is created for an "API" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_STAGE_DEV


@when('a dev stage is created for an "API"')
def create_dev_stage(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        if api_id is None:
            raise Exception("No REST API found; cannot create dev stage")
        deps = ApigatewayTestClient(lws_session).get_deployments(restApiId=api_id)
        dep_items = deps.get("items", [])
        dep_id = dep_items[0]["id"] if dep_items else None
        if dep_id is None:
            raise Exception("No deployment found; cannot create dev stage")
        if world.get("_dev_stage_pre_exists"):
            raise Exception(f"Stage '{TEST_STAGE_DEV}' already exists for this API")
        world["result"] = ApigatewayTestClient(lws_session).create_stage(
            restApiId=api_id, stageName=TEST_STAGE_DEV, deploymentId=dep_id
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
