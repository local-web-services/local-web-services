"""When: throttling was "DISABLED" for the "api gateway" "prod stage" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_STAGE_PROD


@when('throttling was "DISABLED" for the "api gateway" "prod stage"')
def disable_throttling_prod_stage(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        world["result"] = ApigatewayTestClient(lws_session).update_stage(
            restApiId=api_id,
            stageName=TEST_STAGE_PROD,
            patchOperations=[
                {
                    "op": "replace",
                    "path": "/defaultRouteSettings/throttlingBurstLimit",
                    "value": "0",
                },
                {
                    "op": "replace",
                    "path": "/defaultRouteSettings/throttlingRateLimit",
                    "value": "0",
                },
            ],
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
