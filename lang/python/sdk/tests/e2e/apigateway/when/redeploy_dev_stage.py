"""When: the dev stage is redeployed to a new deployment"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_STAGE_DEV


@when("the dev stage is redeployed to a new deployment")
def redeploy_dev_stage(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        new_dep = ApigatewayTestClient(lws_session).create_deployment(restApiId=api_id)
        world["result"] = ApigatewayTestClient(lws_session).update_stage(
            restApiId=api_id,
            stageName=TEST_STAGE_DEV,
            patchOperations=[{"op": "replace", "path": "/deploymentId", "value": new_dep["id"]}],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
