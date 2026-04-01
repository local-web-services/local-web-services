"""When: a "GET" method is created on a "api gateway" "resource" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import when

from ..client import ApigatewayTestClient
from ..constants import TEST_AUTH_TYPE, TEST_HTTP_METHOD


@when('a "GET" method is created on a "api gateway" "resource"')
def create_get_method_on_resource(lws_session, world):
    try:
        api_id = ApigatewayTestClient(lws_session).get_api_id()
        if api_id is None:
            raise Exception("No REST API found; cannot create method on a non-existent resource")
        resource_id = ApigatewayTestClient(lws_session).get_root_resource_id(api_id)
        try:
            ApigatewayTestClient(lws_session).get_method(
                restApiId=api_id, resourceId=resource_id, httpMethod=TEST_HTTP_METHOD
            )
            raise Exception(
                f"Method '{TEST_HTTP_METHOD}' already exists on resource '{resource_id}'"
            )
        except ClientError:
            pass
        world["result"] = ApigatewayTestClient(lws_session).put_method(
            restApiId=api_id,
            resourceId=resource_id,
            httpMethod=TEST_HTTP_METHOD,
            authorizationType=TEST_AUTH_TYPE,
        )
        world["error"] = None
    except (ClientError, Exception) as exc:
        world["result"] = None
        world["error"] = exc
