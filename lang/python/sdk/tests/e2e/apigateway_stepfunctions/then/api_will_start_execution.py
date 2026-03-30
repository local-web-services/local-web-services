"""Then: the "API" will synchronously start and await an Express Workflow execution per request"""

from __future__ import annotations

import json

from pytest_bdd import then

from ..client import ApigatewayStepfunctionsTestClient
from ..constants import _sm_arn


@then('the "API" will synchronously start and await an Express Workflow execution per request')
def api_will_start_execution(lws_session, world):
    api_id = world.get("api_id") or ApigatewayStepfunctionsTestClient(lws_session).get_api_id()
    assert api_id is not None, "Expected API to exist"
    resp = ApigatewayStepfunctionsTestClient(lws_session).invoke_api(
        api_id, {"stateMachineArn": _sm_arn(), "input": json.dumps({"check": "ok"})}
    )
    expected_status = 200
    actual_status = resp["status_code"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}: {resp['body']}"
