"""When: a 200 method response is configured"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_HTTP_METHOD, TEST_STATUS_CODE


@when("a 200 method response is configured")
def configure_200_method_response(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        if api_id is None:
            raise Exception("No REST API found; cannot configure method response")
        resource_id = ApigatewayTestClient(lws_session).get_root_resource_id(api_id)
        ApigatewayTestClient(lws_session).get_method(
            restApiId=api_id, resourceId=resource_id, httpMethod=TEST_HTTP_METHOD
        )
        world["result"] = ApigatewayTestClient(lws_session).put_method_response(
            restApiId=api_id,
            resourceId=resource_id,
            httpMethod=TEST_HTTP_METHOD,
            statusCode=TEST_STATUS_CODE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
