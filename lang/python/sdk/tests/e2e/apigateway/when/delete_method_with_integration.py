"""When: a "api gateway" "method" is deleted along with its integration"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_HTTP_METHOD


@when('a "api gateway" "method" is deleted along with its integration')
def delete_method_with_integration(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        if api_id is None:
            raise Exception("No REST API found; cannot delete a non-existent method")
        resource_id = ApigatewayTestClient(lws_session).get_root_resource_id(api_id)
        ApigatewayTestClient(lws_session).get_method(
            restApiId=api_id, resourceId=resource_id, httpMethod=TEST_HTTP_METHOD
        )
        world["result"] = ApigatewayTestClient(lws_session).delete_method(
            restApiId=api_id, resourceId=resource_id, httpMethod=TEST_HTTP_METHOD
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
