"""When: an "API" deployment is created"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient


@when('an "API" deployment is created')
def create_api_deployment(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        if api_id is None:
            raise Exception("No REST API found; cannot create deployment")
        api_detail = ApigatewayTestClient(lws_session).get_rest_api(restApiId=api_id)
        actual_status = api_detail.get("status", "ACTIVE")
        expected_status = "ACTIVE"
        if actual_status != expected_status:
            raise Exception(
                f"Cannot create deployment: API status is '{actual_status}', expected '{expected_status}'"  # noqa: E501
            )
        world["result"] = ApigatewayTestClient(lws_session).create_deployment(restApiId=api_id)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
