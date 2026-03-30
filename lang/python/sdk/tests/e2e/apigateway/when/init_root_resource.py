"""When: a root resource is initialized for an "API" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient


@when('a root resource is initialized for an "API"')
def init_root_resource(lws_session, world):
    """Map to get_rest_api + get_resources — requires API to exist and be ACTIVE."""
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        if api_id is None:
            raise Exception("No REST API found to initialize root resource for")
        api_detail = ApigatewayTestClient(lws_session).get_rest_api(restApiId=api_id)
        actual_status = api_detail.get("status", "ACTIVE")
        expected_status = "ACTIVE"
        if actual_status != expected_status:
            raise Exception(
                f"Cannot initialize root resource: API status is '{actual_status}', expected '{expected_status}'"  # noqa: E501
            )
        world["result"] = ApigatewayTestClient(lws_session).get_resources(restApiId=api_id)
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
