"""When: a Step Functions direct integration is configured on the "REST" "API" """

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayStepfunctionsTestClient


@when('a Step Functions direct integration is configured on the "REST" "API"')
def configure_sfn_integration_apigw(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    try:
        api_id = ApigatewayStepfunctionsTestClient(lws_session).get_api_id()
        if api_id is None:
            world["result"] = None
            world["error"] = Exception("REST API not found")
            return
        ApigatewayStepfunctionsTestClient(lws_session).configure_sfn_integration(api_id)
        world["result"] = {"configured": True}
        world["error"] = None
        world["api_id"] = api_id
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
