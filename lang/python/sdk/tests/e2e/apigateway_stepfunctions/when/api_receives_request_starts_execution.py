"""When: the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution"""

from __future__ import annotations

import json

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayStepfunctionsTestClient
from ..constants import _sm_arn


@when(
    'the "api gateway" "API" receives a "HTTP" request and synchronously starts a Step Functions execution'
)
def api_receives_request_starts_execution(lws_session, world):
    try:
        api_id = world.get("api_id") or ApigatewayStepfunctionsTestClient(lws_session).get_api_id()
        resp = ApigatewayStepfunctionsTestClient(lws_session).invoke_api(
            api_id,
            {"stateMachineArn": _sm_arn(), "input": json.dumps({"key": "value"})},
        )
        world["result"] = resp
        world["invoke_status"] = resp["status_code"]
        if resp["status_code"] != 200:
            world["error"] = Exception(
                f"API request failed with status {resp['status_code']}: {resp.get('body', '')}"
            )
        else:
            world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
