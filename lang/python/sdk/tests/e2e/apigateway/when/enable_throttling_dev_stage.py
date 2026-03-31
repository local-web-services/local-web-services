"""When: throttling was "ENABLED" for the "api gateway" "prod stage" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_STAGE_DEV


@when('throttling was "ENABLED" for the "api gateway" "prod stage"')
def enable_throttling_dev_stage(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        world["result"] = ApigatewayTestClient(lws_session).update_stage(
            restApiId=api_id,
            stageName=TEST_STAGE_DEV,
            patchOperations=[
                {
                    "op": "replace",
                    "path": "/defaultRouteSettings/throttlingBurstLimit",
                    "value": "100",
                },
                {
                    "op": "replace",
                    "path": "/defaultRouteSettings/throttlingRateLimit",
                    "value": "50",
                },
            ],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
